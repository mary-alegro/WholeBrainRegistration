function preprocessa_normaliza_cinapce(casos, imagens_treino, tipo_marca, params)

%CASOS : lista com diretorios das imagens dos casos a ser processados
%PARAMS_DIFF : paramentros da difusao anisotropica. default: [5 1/7 5 1]

[r c N] = size(casos);

%carrega imagens para treino
l = length(imagens_treino);
treino = [];
for i=1:l
    dcm = dicomread(imagens_treino{i});
    [rows cols N] = size(dcm);
    if rows ~= 464
        dcm = rot90(dcm,-1);
    end
    treino = cat(1,treino,dcm);
end

%calcula marcas a partir do volume de treino
marcas_normalizacao = treina_normaliza_mri(params,treino,tipo_marca);

%normalizacao
for c=1:r
    dir_caso = casos(c,1:end);
    dir_mascarado = strcat(dir_caso,'2.mascarado/');
    dir_normalizado = strcat(dir_caso,'3.normalizado/');
    
    arquivos = dir(strcat(dir_mascarado,'*.dcm'));
    nArqs = length(arquivos);
    for i = 1:nArqs
        arquivo = arquivos(i);
        if ~strcmp(arquivo.name,'.') && ~strcmp(arquivo.name,'..')      
                nome_img = strcat(dir_mascarado,arquivo.name);
                nome_img_s = strcat(dir_normalizado,arquivo.name);
                img = dicomread(nome_img);
                img = gscale(img);
                
                %aplica normalizacao
                img2 = normaliza_mri(params,[],img,tipo_marca,marcas_normalizacao);
                
                %salva imagem no diretorio de imagens suavizadas
                dicomwrite(gscale(img2), nome_img_s);
        end
    end    
    
end