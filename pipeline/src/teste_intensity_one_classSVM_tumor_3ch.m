function teste_intensity_one_classSVM_tumor_3ch()

img1 = imread('emily2.tif');
img2 = imread('emily3.tif');
img3 = imread('emily4.tif');


img1 = mat2gray(img1);
img2 = mat2gray(img2);
img3 = mat2gray(img3);

mask1 = imread('emily2_mask_2class.bmp');
mask2 = imread('emily3_mask_2class.bmp');
mask3 = imread('emily4_mask_2class.bmp');

tumor1 = img1(mask1 == 204);
tumor2 = img2(mask2 == 204);
tumor3 = img3(mask3 == 204);

treino = [tumor1; tumor2; tumor1; tumor2];
labels = ones(size(treino,1),1);

model = svmtrain(labels,treino,'-s 2 -t 2 -n 0.4');

teste = img3(mask3 ~= 255);
labels_teste = zeros(size(teste,1),1);

indices = find(mask3 ~= 255);

'classificando...'
[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);

saida = zeros(size(img3));
saida(indices(classificacao == 1)) = 255;

imwrite(saida,'saida2.bmp','BMP');

'terminou'

