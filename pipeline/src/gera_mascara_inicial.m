function [mask,imagem] = gera_mascara_inicial(img)

% ajustado para FLAIR


img1 = imadjust(img,[0.20 0.75],[0 1],0.8); %melhora contraste

limiar = acha_limiar(img1); %acha limiar automaticamente

img2 = threshold(img1,limiar); %limiariza

imagem = img1;

se = [1 1 1; 1 1 1; 1 1 1];
%se = [1 1; 1 1; 1 1];

img3 = imerode(img2,se);
%img3 = imerode(img3,se);

[labels num] = bwlabel(img3);

maior = 0;
label = 0;

%pega maior regiao
for i = 1:num
    n = size(labels(labels == i),1);
    
    if n > maior
        maior = n;
        label = i;
    end    
end

img = zeros(size(img));
img(labels == label) = 255;

se = strel('disk',10);
img1 = imclose(img,se); %suaviza contorno

se = strel('disk',5);
img2 = imopen(img1,se); %retira artefatos que sobraram, como ruidos e restos de tecido

se = [1 1 1; 1 1 1; 1 1 1];
img2 = imerode(img2,se);

mask = tapa_buracos(img2); %principalmente tapa ventriculos

se = strel('square',20); %15
mask = imerode(mask,se);