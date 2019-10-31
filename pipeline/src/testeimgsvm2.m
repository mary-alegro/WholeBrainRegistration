function [out,model] = testeimgsvm2()

msk1 = imread('teste1-mascara.jpg');
msk2 = imread('teste2-mascara.jpg');
msk3 = imread('teste3-mascara.jpg');

img1 = imread('teste1.jpg');
img2 = imread('teste2.jpg');
img3 = imread('teste3.jpg');
img_teste = imread('teste1.jpg');

img1 = mat2gray(img1);
img2 = mat2gray(img2);
img3 = mat2gray(img3);
img_teste = mat2gray(img_teste);

out = zeros(size(img1));

tumor = [img1(msk1 == 0); img2(msk2 == 0); img3(msk3 == 0)]; %classe -1
cerebro = [img1(msk1 ~= 0 & msk1 ~= 255); img2(msk2 ~= 0 & msk2 ~=255); img3(msk3 ~= 0 & msk3 ~=255)];

labels = [zeros(size(tumor,1),1); ones(size(cerebro,1),1)];
labels(labels==0) = -1;
treino = [tumor; cerebro];

model = svmtrain(labels,treino,'-c 1 -w-1 5 -w1 1 -g 2 -b 1');

teste = img_teste(msk1 ~= 255);

labels_teste = ones(size(teste,1),1);

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);

out = img_teste;

out(classificacao == -1) = 255;







