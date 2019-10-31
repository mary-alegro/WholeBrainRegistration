function [out] = testeimgsvm(M)

msk = imread('teste6-mascara.jpg');
img = imread('teste6.jpg');
img = mat2gray(img); %scale
out = zeros(size(img));

csf = img(msk == 0); %1
wm = img(msk == 190); %2
gm = img(msk == 113); %3

nCsf = size(csf,1);
nWm = size(wm,1);
nGm = size(gm,1);

treino = [csf; wm; gm];

labels = ones(nCsf+nWm+nGm,1);
labels(nCsf+1:end,:) = 2;
labels(nCsf+nWm+1:end,:) = 3;

%model = svmtrain(labels,treino,'-c 1 -g 2 -b 1');

teste = img(msk ~= 255);
indices = find(msk ~= 255);

labels_teste = zeros(size(teste));

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, M);

corCSF = 100;
corWM = 200;
corGM = 128;

out(indices(classificacao == 1)) = corCSF;
out(indices(classificacao == 2)) = corWM;
out(indices(classificacao == 3)) = corGM;














