function [struct] = extrai_markov(img_strut, struct)

%
% Calcula os parametros de textura por um campo aleatorio de markov
% gaussiano, utilizando Estimativa dos Minimos Quadrados
%

ordens = 1:5;
janela = 9;
nErros = 0;

struct = aloca_espaco(struct,ordens,img_strut);

fprintf('Iniciando calculo das texturas por Markov (MRF)...\n');

for o = ordens
    
    fprintf('calculando ordem %d\n',o);

    
    for s = 1:3 %itera fatias

        mask = img_strut.mask(:,:,s);
        indices = find(mask ~= 0);
        len = length(indices);
        
        img_T1 = img_strut.T1(:,:,s);
        img_T1c = img_strut.T1c(:,:,s);
        img_FLAIR = img_strut.FLAIR(:,:,s);
                
        for t=1:len
            
            %T1
            try
                w = getwindow(indices(t),img_T1,janela);
            catch
                nErros = nErros+1;
                continue;
            end            
            theta_T1 = markov_calcula_theta(w,o); %calcula parametros para a janela w, referente a ordem o
            struct.mri(1).s(s).markov.ordem(o).theta(t,:) = theta_T1(:);
            
            %T1c
            try
                w = getwindow(indices(t),img_T1c,janela);
            catch
                nErros = nErros+1;
                continue;
            end            
            theta_T1c = markov_calcula_theta(w,o); %calcula parametros para a janela w, referente a ordem o
            struct.mri(2).s(s).markov.ordem(o).theta(t,:) = theta_T1c(:);
            
            %FLAIR
            try
                w = getwindow(indices(t),img_FLAIR,janela);
            catch
                nErros = nErros+1;
                continue;
            end            
            theta_FLAIR = markov_calcula_theta(w,o); %calcula parametros para a janela w, referente a ordem o
            struct.mri(3).s(s).markov.ordem(o).theta(t,:) = theta_FLAIR(:);           
            
        end

    end
end

fprintf('Numero de erros: %d\n',nErros);


function [struct] = aloca_espaco(struct,ordens,img_strut)

    nViz = [2 4 6 10 12]; %no. ve vizinhos de acordo com a ordem (ordem = indice do vetor)
    
    for o = ordens
        for s=1:3
            mask = img_strut.mask(:,:,s);
            indices = find(mask ~= 0);
            len = length(indices);
            
            struct.mri(1).s(s).markov.ordem(o).theta = zeros(len,nViz(o)+1); %nViz(o)+1 = n de vizinhos + a variancia
            struct.mri(2).s(s).markov.ordem(o).theta = zeros(len,nViz(o)+1);
            struct.mri(3).s(s).markov.ordem(o).theta = zeros(len,nViz(o)+1);
        end
    end

    