function [struct] = extrai_dim_fractal(img_strut,struct)

%
% Maryana de Carvalho Alegro
% maryana@lsi.usp.br
%
%
% Extrai informacoes de textura por dimensao fractal
%


janela = 9;

nErros = 0;

struct = aloca_espaco(struct,img_strut); %aloca espacao

fprintf('Iniciando calculo das texturas por Dimensao Fractal...\n');

for s=1:3
    mask = img_strut.mask(:,:,s);
    img_T1 = img_strut.T1(:,:,s);
    img_T1c = img_strut.T1c(:,:,s);
    img_FLAIR = img_strut.FLAIR(:,:,s);
    
    indices = find(mask ~= 0);
    len = length(indices);
    
    for t=1:len
    
        %T1
        try
            w = getwindow(indices(t),img_T1,janela);
        catch
            nErros = nErros+1;
            continue;
        end
        
        FD = PTPSA(w);
        struct.mri(1).s(s).fractal(t) = FD;
        
        %T1c
        try
            w = getwindow(indices(t),img_T1c,janela);
        catch
            nErros = nErros+1;
            continue;
        end
        
        FD = PTPSA(w);
        struct.mri(2).s(s).fractal(t) = FD;
        
        %FLAIR
        try
            w = getwindow(indices(t),img_FLAIR,janela);
        catch
            nErros = nErros+1;
            continue;
        end
        
        FD = PTPSA(w);
        struct.mri(3).s(s).fractal(t) = FD;
        
    end
    
end
 
fprintf('Numero de erros: %d\n',nErros);



%aloca espaco na estrutura de dados
function [struct] = aloca_espaco(struct,img_strut)
     
     for s=1:3
         mask = img_strut.mask(:,:,s);
         rows = length(find(mask ~= 0));
         cols = 1;
         
         struct.mri(1).s(s).fractal = zeros(rows,cols);   
         struct.mri(2).s(s).fractal = zeros(rows,cols);
         struct.mri(3).s(s).fractal = zeros(rows,cols);
     end
