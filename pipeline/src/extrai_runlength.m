function [struct] = extrai_runlength(img_strut,struct)
                                   
 %
 % Extrai dados de textura atraves das matrizes run-length
 %

janela = 9;

struct = incializa_ed(img_strut,struct); %inicializa estrutura de dados

nErros = 0;

fprintf('Iniciando calculo das texturas por Matriz Run-length...\n');

for s=1:3
    
    mask = img_strut.mask(:,:,s);
    img_T1 = img_strut.T1(:,:,s);
    img_T1c = img_strut.T1c(:,:,s);
    img_FLAIR = img_strut.FLAIR(:,:,s);
    
    indices = find(mask ~= 0);
    len = length(indices);
    
    for t=1:len
        
        % T1        
        try
            w = getwindow(indices(t),img_T1,janela);
        catch
            nErros = nErros+1;
            continue;
        end    

        ccm = grayrlmatrix(w); 
        props = grayrlprops(ccm); %matriz 4(direcoes) x 11(caracteristicas): [SRE LRE GLN RLN  RP LGRE HGRE SGLGE SRHGE LRLGE  LRHGE ]

        struct.mri(1).s(s).SRE(t,:) = props(:,1)';
        struct.mri(1).s(s).LRE(t,:) = props(:,2)';
        struct.mri(1).s(s).GLN(t,:) = props(:,3)';
        struct.mri(1).s(s).RLN(t,:) = props(:,4)';
        struct.mri(1).s(s).RP(t,:) = props(:,5)';
        struct.mri(1).s(s).LGRE(t,:) = props(:,6)';
        struct.mri(1).s(s).HGRE(t,:) = props(:,7)';
        struct.mri(1).s(s).SRLGE(t,:) = props(:,8)';
        struct.mri(1).s(s).SRHGE(t,:) = props(:,9)';
        struct.mri(1).s(s).LRLGE(t,:) = props(:,10)';
        struct.mri(1).s(s).LRHGE(t,:) = props(:,11)';
        
        
        % T1c
        try
            w = getwindow(indices(t),img_T1c,janela);
        catch
            nErros = nErros+1;
            continue;
        end    

        ccm = grayrlmatrix(w);
        props = grayrlprops(ccm);

        struct.mri(2).s(s).SRE(t,:) = props(:,1)';
        struct.mri(2).s(s).LRE(t,:) = props(:,2)';
        struct.mri(2).s(s).GLN(t,:) = props(:,3)';
        struct.mri(2).s(s).RLN(t,:) = props(:,4)';
        struct.mri(2).s(s).RP(t,:) = props(:,5)';
        struct.mri(2).s(s).LGRE(t,:) = props(:,6)';
        struct.mri(2).s(s).HGRE(t,:) = props(:,7)';
        struct.mri(2).s(s).SRLGE(t,:) = props(:,8)';
        struct.mri(2).s(s).SRHGE(t,:) = props(:,9)';
        struct.mri(2).s(s).LRLGE(t,:) = props(:,10)';
        struct.mri(2).s(s).LRHGE(t,:) = props(:,11)';
        
        
        % FLAIR
        try
            w = getwindow(indices(t),img_FLAIR,janela);
        catch
            nErros = nErros+1;
            continue;
        end    

        ccm = grayrlmatrix(w);
        props = grayrlprops(ccm);

        struct.mri(3).s(s).SRE(t,:) = props(:,1)';
        struct.mri(3).s(s).LRE(t,:) = props(:,2)';
        struct.mri(3).s(s).GLN(t,:) = props(:,3)';
        struct.mri(3).s(s).RLN(t,:) = props(:,4)';
        struct.mri(3).s(s).RP(t,:) = props(:,5)';
        struct.mri(3).s(s).LGRE(t,:) = props(:,6)';
        struct.mri(3).s(s).HGRE(t,:) = props(:,7)';
        struct.mri(3).s(s).SRLGE(t,:) = props(:,8)';
        struct.mri(3).s(s).SRHGE(t,:) = props(:,9)';
        struct.mri(3).s(s).LRLGE(t,:) = props(:,10)';
        struct.mri(3).s(s).LRHGE(t,:) = props(:,11)';
        
    end
    
end

fprintf('Numero de erros: %d\n',nErros);


%%%%%%%%%%%%%%%%%%%%%%%

function struct = incializa_ed(img_strut,struct)

    
    for mri=1:3
        for s=1:3    
            
            mask = img_strut.mask(:,:,s);
            indices = find(mask ~= 0);
            len = length(indices);
            
            struct.mri(mri).s(s).SRE = zeros(len,4);
            struct.mri(mri).s(s).LRE = zeros(len,4);
            struct.mri(mri).s(s).GLN = zeros(len,4);
            struct.mri(mri).s(s).RLN = zeros(len,4);
            struct.mri(mri).s(s).RP = zeros(len,4);
            struct.mri(mri).s(s).LGRE = zeros(len,4);
            struct.mri(mri).s(s).HGRE = zeros(len,4);
            struct.mri(mri).s(s).SRLGE = zeros(len,4);
            struct.mri(mri).s(s).SRHGE = zeros(len,4);
            struct.mri(mri).s(s).LRLGE = zeros(len,4);
            struct.mri(mri).s(s).LRHGE = zeros(len,4);    
        end
    end
    
    