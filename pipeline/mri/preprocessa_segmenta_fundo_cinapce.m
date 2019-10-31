function img2 = preprocessa_segmenta_fundo_cinapce(casos,nIter)


%CASOS : lista com diretorios das imagens dos casos a ser processados
%NITER : numero de iteracoes

[r c N] = size(casos);

for c=1:r
    dir_caso = casos(c,1:end);
    dir_dicom = strcat(dir_caso,'1.suavizado/');
    dir_suavizado = strcat(dir_caso,'2.mascarado/');
    
    arquivos = dir(strcat(dir_dicom,'*.dcm'));
    nArqs = length(arquivos);
    for i = 1:nArqs
        arquivo = arquivos(i);
        if ~strcmp(arquivo.name,'.') && ~strcmp(arquivo.name,'..')      
                nome_img = strcat(dir_dicom,arquivo.name);
                nome_img_s = strcat(dir_suavizado,arquivo.name);
                img = dicomread(nome_img);
                img = gscale(img);
                
                %aplica extracao de fundo
                img2 = segmenta(img,nIter);
                
                %salva imagem no diretorio de imagens suavizadas
                dicomwrite(gscale(img2), nome_img_s);
        end
    end    
    
end



