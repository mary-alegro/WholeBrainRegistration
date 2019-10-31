function [volume] = normaliza_mri(param,treino,teste,L,params_treino)

%
% VOLUME = NORMALIZA_MRI(PARAM,TREINO,TESTE,L,PARAMS_TREINO)
%
% VOLUME : pilha com imagens normalizadas
%
% PARAM : parametros da normalizacao ([s1 s2 pc1 pc2])       
%       s1: valor minimo da escala padrao
%       s2: valor maximo da escala padrao
%       pc1: procentagem de limiarizacao do comeco do histograma [0,1]
%       pc2: procentagem de limiarizacao do final do histograma [0,1]
%
% TREINO : pilha com imagens usadas para extrair paramentros de
% normalizacao (assume imagens ja sem o fundo)
% 
% TESTE : pilha com imagens que ser quer normalizar (assume imagens ja sem o fundo)
%
% L : tipo de marca (landmark) de histograma a ser utilizado na
% normalizacao
%
% PARAMS_TREINO : marcas obtidas por treino previo usando a funcao
% TREINA_NORMALIZA_MRI
%
%-------------------------------------------------------------------------
%  Normaliza imagens de RM usando os metodos de Nyul e Udupa         
%                                                                         
% "On Standardizing the MR Image Intensity Scale"                         
%   Magnetic Resonance Medicine 42:1072-1081 (1998)                       
%                                                                         
% "New Variants of a Method of MRI Scale Standardization"                 
%  IEEE Transactions on Medical Imaging, vol. 19 no. 2 (2000)             
%-------------------------------------------------------------------------


s1 = param(1);
s2 = param(2);
pc1 = param(3);
pc2 = param(4);

if min(teste(:)) < 0 || max(teste(:)) > 65535
    error('Valores de intensidade do volume de TESTE devem ser entre 0 e 65535');
end

%evitar problemas de tipo
treino = double(treino);
teste = double(teste);

% verifica existencia de treino anterior
if isempty(params_treino)
    marcas = calcula_marcas_normalizacao(param,treino,L); % calcula intensidade media das marcas, a partir de imagens de "treino"
    standard = [s1 marcas s2];
else
    standard = params_treino;
end

volume = zeros(size(teste));

%normaliza imagens
[rows,cols,N] = size(teste);

for i = 1:N
    img = teste(:,:,i);   
    
    marcas = acha_locais_normalizacao(img,pc1,pc2,L); % acha as marcas da imagem IMG  
    
    histo = histograma(img); %pre-supoe imagem sem fundo
    histo(1) = 0; %tira ocorrencia de fundo (intensidade 0)
    
    % acha minimo e maximo diferentes de 0
    minH = find(histo,1)-1;
    maxH = find(histo,1,'last')-1;
    
    
    for r = 1:rows
        for c = 1:cols
            t = img(r,c);           
            if(t > 0)
                t = mapeia_intensidade([minH maxH pc1 pc2],standard,marcas,t); % realiza mapeamento linear
            end
            volume(r,c,i) = t;
        end
    end           
    
    
end



%-----------------------------------------------------------------%
% mapeia intensidades              
%-----------------------------------------------------------------%
function y = mapeia_intensidade(par, escala_std, escala_img, x)
    
    %m1 = par(1);
    %m2 = par(2);
    pc1 = par(3);
    pc2 = par(4);
    y = 0;
    
    len = size(escala_std,2);    
    
    if(x < escala_img(1) && pc1 > 0) % mapeia [m1i p1i] em [s1',s1]            
        y = (escala_std(2) - escala_std(1)) / (escala_img(2) - escala_img(1)) * (x - escala_img(1)) + escala_std(1);
        return
    elseif(x > escala_img(len) && pc2 < 1) % mapeia [p2i m2i] em [s2,s2']            
        y = (escala_std(len) - escala_std(len-1)) / (escala_img(len) - escala_img(len-1)) * (x - escala_img(len-1)) + escala_std(len-1);
        return
    end
    
    for i=1:len-1
        if(escala_img(i) <= x && x <= escala_img(i+1))
            y = (escala_std(i+1) - escala_std(i)) / (escala_img(i+1) - escala_img(i)) * (x - escala_img(i)) + escala_std(i);
            break
        end
    end
    
    y = ceil(y);




