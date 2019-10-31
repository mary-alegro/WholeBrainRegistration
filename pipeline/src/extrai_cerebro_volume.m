function volume = extrai_cerebro_volume(imagens,dimX,dimY)

%IMAGENS deve conter as imagens DICOM na ordem correta, e devem ser todas
%do mesmo tamanho (dimX,dimY) final

diretorio = 'volume';

len = size(imagens,1);

volume = zeros(dimY,dimX,len);

nIter = 80;

for i = 1:len
    imagem = imagens(i);
    imagem = strcat(diretorio,'/',imagem);
    imagem = char(imagem);
    
    img = gscale(dicomread(imagem));
    img = imresize(img,0.5,'bilinear'); %redimensiona a imagem
    
    img2 = gscale(anisodiff2D(img,3,0.1429,10,2)); %filtra ruido com difusao anisotropica
    
    mask =  extrai_cerebro(img2,nIter);
    
    %if i == len
        %i = 1;
    %end
    
    volume(:,:,i) = mask;    
end

diretorio2 = 'volume2';

for j = 1:len
    img = volume(:,:,j);
    nome = strcat(diretorio2,'/','saida',int2str(j),'.bmp');
    imwrite(img,nome,'BMP');
end
