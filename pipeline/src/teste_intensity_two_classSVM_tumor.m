%function model = teste_texture()
function teste_texture()

'iniciando...'

img1 = imread('emily3.bmp');

img1 = img1(:,:,1);

%scaling
img1 = im2double(img1);

mask = imread('emily3_mask_2class.bmp');

tumor = img1(mask == 242);
tecido_normal = img1(mask == 204);

treino = [tumor; tecido_normal];
labels = ones(size(tumor,1),1); % tumor = 1
labels = [labels; zeros(size(tecido_normal,1),1)]; % tecido normal = 0

treino = [treino; treino; treino; treino];
labels = [labels; labels; labels; labels];

'treinando...'
model = svmtrain(labels,treino,'-c 1 -g 2 -b 1');
%model = svmtrain(labels,treino,'-s 2 -t 2 -n 0.5');

teste = img1(mask ~= 255);
labels_teste = zeros(size(teste,1),1);
indices = find(mask ~= 255);

'classificando...'
[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);

saida = zeros(size(img1));
saida(indices(classificacao == 1)) = 255;

imwrite(saida,'saida2.bmp','BMP');

'terminou'

