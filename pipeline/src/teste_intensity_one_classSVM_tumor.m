%function model = teste_texture()
function teste_texture()

'iniciando...'

img1 = imread('emily3.bmp');

img1 = img1(:,:,1);

%scaling
img1 = im2double(img1);

mask = imread('emily3_mask_2class.bmp');

treino = ones(size(mask((mask == 242)),1),16);
labels = ones(size(mask((mask == 242)),1),1); %one-class -> tecido normal = 1

treino(:,1) = img1(mask == 242);

treino = [treino; treino; treino; treino];
labels = [labels; labels; labels; labels];

'treinando...'
%model = svmtrain(labels,treino,'-c 1 -g 2 -b 1 -w1 1 -w-1 16');
model = svmtrain(labels,treino,'-s 2 -t 2 -n 0.4');

teste = ones(size(mask(mask ~= 255),1),16);
labels_teste = zeros(size(teste,1),1);

teste(:,1) = img1(mask ~= 255);

indices = find(mask ~= 255);

'classificando...'
[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);

saida = zeros(size(img1));
saida(indices(classificacao == 1)) = 255;

imwrite(saida,'saida2.bmp','BMP');

'terminou'

