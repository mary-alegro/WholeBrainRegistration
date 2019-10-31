%function model = teste_texture()
function model = teste_intensity_3_classSVM()

'iniciando...'

img1 = imread('emily1.tif');

img1 = img1(:,:,1);

%scaling
img1 = im2double(img1);

mask = imread('emily1_mask_4class.bmp');

%MB - 230 (classe 0)
%MC - 178 (classe 1)
%LIQUOR - 0 (classe -1)

mb = img1(mask == 230);
mc = img1(mask == 178);
liquor = img1(mask == 0);

treino = [mb; mc; liquor];

labels = zeros(size(treino,1),1);
labels(size(mb,1)+1:end,1) = 1;
labels(size(mb,1)+size(mc,1)+1:end,1) = -1;


%treino = [treino; treino; treino; treino];
%labels = [labels; labels; labels; labels];

'treinando...'
model = svmtrain(labels,treino,'-c 1 -g 2 -b 1');
%model = svmtrain(labels,treino,'-s 2 -t 2 -n 0.5');

%teste = img1(mask ~= 255);
%labels_teste = zeros(size(teste,1),1);
%indices = find(mask ~= 255);

%'classificando...'
%[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);

%saida = zeros(size(img1));
%saida(indices(classificacao == 0)) = 90;
%saida(indices(classificacao == 1)) = 128;
%saida(indices(classificacao == -1)) = 200;

%imwrite(saida,'saida.bmp','BMP');

%'terminou'


