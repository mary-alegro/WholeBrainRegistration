function [struct] = extrai_gabor(img_strut,struct)

parametros = [[0.05; 0.05; 0; 0] [0.05; 0.05; 45; 0] [0.05; 0.05; 90; 0] [0.05; 0.025; 0; 0] [0.05; 0.025; 45; 0] [0.05; 0.025; 90; 0]];

nCanais = size(parametros,2);
banco = [];

%monta banco de filtros
for c=1:nCanais
    G = gaborfilter2(parametros(1,c),parametros(2,c),parametros(3,c),parametros(4,c));
    banco = cat(3,banco,G);
end

nFiltros = size(banco,3);

janela = 9;

nErros = 0;

struct = aloca_espaco(img_strut,struct,banco);


fprintf('Iniciando calculo das texturas por Filtros de Gabor...\n');

for s = 1:3
    
    mask = img_strut.mask(:,:,s);
    indices = find(mask ~= 0);
    len = length(indices);
         
    img_T1 = img_strut.T1(:,:,s);
    img_T1c = img_strut.T1c(:,:,s);
    img_FLAIR = img_strut.FLAIR(:,:,s);
    
    %T1
    for t=1:len
        try
            w = getwindow(indices(t),img_T1,janela);
        catch
            nErros = nErros+1;
            continue;
        end
        
        for f=1:nFiltros
            G = banco(:,:,f);
            filtrado = conv2(double(w),double(G),'same');
            en = energia_media(filtrado);
            struct.mri(1).s(s).gabor(t,f) = en;
        end
    end
    
    %T1c
    for t=1:len
        try
            w = getwindow(indices(t),img_T1c,janela);
        catch
            nErros = nErros+1;
            continue;
        end
        
        for f=1:nFiltros
            G = banco(:,:,f);
            filtrado = conv2(double(w),double(G),'same');
            en = energia_media(filtrado);
            struct.mri(2).s(s).gabor(t,f) = en;
        end
    end
    
    %FLAIR
    for t=1:len
        try
            w = getwindow(indices(t),img_FLAIR,janela);
        catch
            nErros = nErros+1;
            continue;
        end
        
        for f=1:nFiltros
            G = banco(:,:,f);
            filtrado = conv2(double(w),double(G),'same');
            en = energia_media(filtrado);
            struct.mri(3).s(s).gabor(t,f) = en;
        end
    end
end

fprintf('Numero de erros: %d\n',nErros);



% aloca espaco
function struct = aloca_espaco(img_strut,struct,banco)

N = size(banco,3);

for s = 1:3
    mask = img_strut.mask(:,:,s);
    indices = find(mask ~= 0);
    len = length(indices);
    
    struct.mri(1).s(s).gabor = zeros(len,N);
    struct.mri(2).s(s).gabor = zeros(len,N);
    struct.mri(3).s(s).gabor = zeros(len,N);
end