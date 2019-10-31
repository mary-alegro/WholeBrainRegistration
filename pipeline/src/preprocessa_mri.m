function [volumes] = preprocessa_mri(acoes,argumentos)

% [VOLUMES] = PREPROCESSA_MRI({ACOES}, {DIRETORIOS})
%
%
% [VOLUMES] = PREPROCESSA_MRI({ACOES}, DADOS)
%
%
% {ACOES} : acoes a serem realizadas. pode ser 'NORMALIZAR', 'GERAR_MASCARA' ,'MASCARAR', 'FILTRAR'
% {DIRETORIOS} : cell com nomes dos diretorios, sempre na ordem FLAIR, T1 e
% T1c
% [VOLUMES] : vetor com as matrizes 3D (double) das imagens já carregadas,
% sempre na ordem FLAIR, T1, T1c e MASCARAS 
% DADOS : estrutura do mesmo tipo devolvido por essa funcao

volumes = init_volumes();

mascaras = [];
FLAIR = [];
T1 = [];
T1c = [];

normalizar = 0;
mascarar = 0;
filtrar = 0;
gerar_mascara = 0;

%params diff. anisotropica
num_iter = 10;
delta_t = 1/7;
kappa = 15;
option = 2;

%params normalizacao
params_normalizacao = [1 4095 0 0.998];

%pega parametros entrada
if iscell(acoes) && ~isempty(acoes)    
    for a = acoes
        if (strcmp(char(a),'filtrar'))
            filtrar = 1;
        elseif(strcmp(char(a),'normalizar'))
            normalizar = 1;
        elseif(strcmp(char(a),'mascarar'))
            mascarar = 1;
        elseif(strcmp(char(a),'gerar_mascara'))
            gerar_mascara = 1;
        end
    end
else
    error('Parametros {acoes} incorretos')
end

if iscell(argumentos) && ~isempty(argumentos)
    len = length(argumentos);
    if(len >= 1)
        FLAIR = carrega_volume_dicom(char(argumentos(1)));
    end    
    if(len >= 2)
        T1 = carrega_volume_dicom(char(argumentos(2)));
    end    
    if(len >= 3)
        T1c = carrega_volume_dicom(char(argumentos(3)));
    end
    if(len >= 4)
        mascaras = carrega_volume_dicom(char(argumentos(4)));
    end
    
    % coloca na estrutura
    volumes.vol_original.FLAIR = FLAIR;
    volumes.vol_original.T1 = T1;
    volumes.vol_original.T1c = T1c;
    volumes.mascaras = mascaras;
    
elseif isstruct(argumentos) && ~isempty(argumentos)
    estrutura = argumentos; 
    FLAIR = estrutura.vol_original.FLAIR;    
    T1 = estrutura.vol_original.T1;
    T1c = estrutura.vol_original.T1c;
    mascaras = estrutura.mascaras;
else
    error('Parametros devem ser ou uma estrutura ou um vetor com nomes de diretorios')
end


%faz difusao anisotropica
if filtrar
    
    disp('Aplicando difusao anisotropica...');
    
    if ~isempty(FLAIR)
        [rows cols N] = size(FLAIR);
        for i=1:N
            img = anisodiff2D(FLAIR(:,:,i), num_iter, delta_t, kappa, option);
            FLAIR(:,:,i) = img(:,:);
        end
    end
    
    if ~isempty(T1)
        [rows cols N] = size(T1);
        for i=1:N
            img = anisodiff2D(T1(:,:,i), num_iter, delta_t, kappa, option);
            T1(:,:,i) = img(:,:);
        end
    end
    
    if ~isempty(T1c)
        [rows cols N] = size(T1c);
        for i=1:N
            img = anisodiff2D(T1c(:,:,i), num_iter, delta_t, kappa, option);
            T1c(:,:,i) = img(:,:);
        end
    end
    
    volumes.vol_filtrado.FLAIR = FLAIR;
    volumes.vol_filtrado.T1 = T1;
    volumes.vol_filtrado.T1c = T1c;
end

%gera mascaras
if gerar_mascara   
    
    disp('Iniciando criacao de mascaras...');
    
    [rows,cols,N] = size(FLAIR);
    mascaras = zeros(rows,cols,N);
    nIter = 160;
    nIterFatia = zeros(N,2);

    %gera mascaras iterativamente
    for i=1:N
        
        disp(['Imagem ',int2str(i),' de ',int2str(N),': ']);
        
        novo_nIter = nIter;
        ok = true;
        img = FLAIR(:,:,i);
        while(ok)
            try
                msk = extrai_cerebro(img,novo_nIter);
                nIterFatia(i) = novo_nIter;
            catch
                break;
            end
            novo_nIter = input('Novo numero de iteracoes? ');            
            if isempty(novo_nIter) || novo_nIter <= 0
                ok = false;
                mascaras(:,:,i) = msk(:,:);
            end
        end
        close all;
    end
    
    inicio = input('Primeira fatia de interesse: ');
    fim = input('Ultima fatia de interesse: ');
    
    if(~isempty(inicio) && ~isempty(fim))
        volumes.IOI(1) = inicio;
        volumes.IOI(2) = fim;
    end
    
    volumes.nIter = nIterFatia;
end      

%mascara imagens do volume
if mascarar
    
    if ~isempty(mascaras)

        disp('Mascarando volume...');

        if ~isempty(FLAIR)
            vol_tmp = 0;
            [rows cols N] = size(FLAIR);

            for i=1:N    
                msk = mascaras(:,:,i);
                img = FLAIR(:,:,i);    

                if max(msk(:)) > 0
                   img(msk == 0) = 0;

                   if isscalar(vol_tmp) 
                       vol_tmp = img;
                   else 
                       vol_tmp = cat(3,vol_tmp,img);
                   end
                end
            end

            volumes.vol_mascarado.FLAIR = vol_tmp;
        end

        if ~isempty(T1)
            vol_tmp = 0;
            [rows cols N] = size(T1);

            for i=1:N    
                msk = mascaras(:,:,i);
                img = T1(:,:,i);    

                if max(msk(:)) > 0
                   img(msk == 0) = 0;

                   if isscalar(vol_tmp) 
                       vol_tmp = img;
                   else 
                       vol_tmp = cat(3,vol_tmp,img);
                   end
                end
            end

            volumes.vol_mascarado.T1 = vol_tmp;
        end

        if ~isempty(T1c)
            vol_tmp = 0;
            [rows cols N] = size(T1c);

            for i=1:N    
                msk = mascaras(:,:,i);
                img = T1c(:,:,i);    

                if max(msk(:)) > 0
                   img(msk == 0) = 0;

                   if isscalar(vol_tmp) 
                       vol_tmp = img;
                   else 
                       vol_tmp = cat(3,vol_tmp,img);
                   end
                end
            end

            volumes.vol_mascarado.T1c = vol_tmp;
        end

    end

end

%normaliza intensidades do volume
if normalizar
    
    disp('Normalizando intensidades...');
    
    treino = cat(3,FLAIR,T1,T1c);
    marcas = treina_normaliza_mri(params_normalizacao,treino,'L1');
    
    if ~isempty(FLAIR)
        FLAIR = normaliza_mri(params_normalizacao,treino,FLAIR,'L1',marcas);
        volumes.vol_normalizado.FLAIR = FLAIR;        
    end
    
    if ~isempty(T1)
        T1 = normaliza_mri(params_normalizacao,treino,T1,'L1',marcas);
        volumes.vol_normalizado.T1 = T1;        
    end
    
    if ~isempty(T1c)
        T1c = normaliza_mri(params_normalizacao,treino,T1c,'L1',marcas);
        volumes.vol_normalizado.T1c = T1c;        
    end
end
        
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%55
function volumes = init_volumes()

volumes.nome = [];
volumes.IOI = [0 0];
volumes.nIter = [];
volumes.mascaras = [];

volumes.vol_original.FLAIR = [];
volumes.vol_original.T1 = [];
volumes.vol_original.T1c = [];

volumes.vol_filtrado.FLAIR = [];
volumes.vol_filtrado.T1 = [];
volumes.vol_filtrado.T1c = [];

volumes.vol_mascarado.FLAIR = [];
volumes.vol_mascarado.T1 = [];
volumes.vol_mascarado.T1c = [];

volumes.vol_normalizado.FLAIR = [];
volumes.vol_normalizado.T1 = [];
volumes.vol_normalizado.T1c = [];
end
        

