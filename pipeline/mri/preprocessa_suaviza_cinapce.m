function preprocessa_suaviza_cinapce(casos,params_diff)

%CASOS : lista com diretorios das imagens dos casos a ser processados
%PARAMS_DIFF : paramentros da difusao anisotropica. default: [5 1/7 5 1]

[r c N] = size(casos);

for c=1:r
    dir_caso = casos(c,1:end);
    dir_dicom = strcat(dir_caso,'dicom/');
    dir_suavizado = strcat(dir_caso,'1.suavizado/');
    
    arquivos = dir(strcat(dir_dicom,'*.dcm'));
    nArqs = length(arquivos);
    for i = 1:nArqs
        arquivo = arquivos(i);
        if ~strcmp(arquivo.name,'.') && ~strcmp(arquivo.name,'..')      
                nome_img = strcat(dir_dicom,arquivo.name);
                nome_img_s = strcat(dir_suavizado,arquivo.name);
                img = dicomread(nome_img);
                img = gscale(img);
                
                %aplica difusao anisotropica
                img2 = anisodiff2D(img,params_diff(1),params_diff(2),params_diff(3),params_diff(4));
                
                %salva imagem no diretorio de imagens suavizadas
                dicomwrite(gscale(img2), nome_img_s);
        end
    end    
    
end


