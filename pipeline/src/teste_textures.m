%function model = teste_texture()
function teste_texture()

img1 = imread('S(0,1)AngScMom6b.bmp');
img2 = imread('S(1,0)AngScMom6b.bmp');
img3 = imread('S(1,1)AngScMom6b.bmp');
img4 = imread('S(1,-1)AngScMom6b.bmp');

img5 = imread('S(0,1)Contrast6b.bmp');
img6 = imread('S(1,0)Contrast6b.bmp');
img7 = imread('S(1,1)Contrast6b.bmp');
img8 = imread('S(1,-1)Contrast6b.bmp');

img9 = imread('S(0,1)InvDfMom6b.bmp');
img10 = imread('S(1,0)InvDfMom6b.bmp');
img11 = imread('S(1,1)InvDfMom6b.bmp');
img12 = imread('S(1,-1)InvDfMom6b.bmp');

img13 = imread('S(0,1)SumVarnc6b.bmp');
img14 = imread('S(1,0)SumVarnc6b.bmp');
img15 = imread('S(1,1)SumVarnc6b.bmp');
img16 = imread('S(1,-1)SumVarnc6b.bmp');

img1 = img1(:,:,1);
img2 = img2(:,:,1);
img3 = img3(:,:,1);
img4 = img4(:,:,1);
img5 = img5(:,:,1);
img6 = img6(:,:,1);
img7 = img7(:,:,1);
img8 = img8(:,:,1);
img9 = img9(:,:,1);
img10 = img10(:,:,1);
img11 = img11(:,:,1);
img12 = img12(:,:,1);
img13 = img13(:,:,1);
img14 = img14(:,:,1);
img15 = img15(:,:,1);
img16 = img16(:,:,1);

%scaling
img1 = im2double(img1);
img2 = im2double(img2);
img3 = im2double(img3);
img4 = im2double(img4);
img5 = im2double(img5);
img6 = im2double(img6);
img7 = im2double(img7);
img8 = im2double(img8);
img9 = im2double(img9);
img10 = im2double(img10);
img11 = im2double(img11);
img12 = im2double(img12);
img13 = im2double(img13);
img14 = im2double(img14);
img15 = im2double(img15);
img16 = im2double(img16);

mask = imread('emily3_mask_2class.bmp');

treino = ones(size(mask((mask ~= 255 & mask ~= 242)),1),16);
labels = ones(size(mask((mask ~= 255 & mask ~= 242)),1),1); %one-class -> tecido normal = 1

treino(:,1) = img1(mask ~= 255 & mask ~= 242);
treino(:,2) = img2(mask ~= 255 & mask ~= 242);
treino(:,3) = img3(mask ~= 255 & mask ~= 242);
treino(:,4) = img4(mask ~= 255 & mask ~= 242);
treino(:,5) = img5(mask ~= 255 & mask ~= 242);
treino(:,6) = img6(mask ~= 255 & mask ~= 242);
treino(:,7) = img7(mask ~= 255 & mask ~= 242);
treino(:,8) = img8(mask ~= 255 & mask ~= 242);
treino(:,9) = img9(mask ~= 255 & mask ~= 242);
treino(:,10) = img10(mask ~= 255 & mask ~= 242);
treino(:,11) = img11(mask ~= 255 & mask ~= 242);
treino(:,12) = img12(mask ~= 255 & mask ~= 242);
treino(:,13) = img13(mask ~= 255 & mask ~= 242);
treino(:,14) = img14(mask ~= 255 & mask ~= 242);
treino(:,15) = img15(mask ~= 255 & mask ~= 242);
treino(:,16) = img16(mask ~= 255 & mask ~= 242);


%model = svmtrain(labels,treino,'-c 1 -g 2 -b 1 -w1 1 -w-1 16');
model = svmtrain(labels,treino,'-s 2 -t 2 -n 0.3');

teste = ones(size(mask(mask ~= 255),1),16);
labels_teste = zeros(size(teste,1),1);

teste(:,1) = img1(mask ~= 255);
teste(:,2) = img2(mask ~= 255);
teste(:,3) = img3(mask ~= 255);
teste(:,4) = img4(mask ~= 255);
teste(:,5) = img5(mask ~= 255);
teste(:,6) = img6(mask ~= 255);
teste(:,7) = img7(mask ~= 255);
teste(:,8) = img8(mask ~= 255);
teste(:,9) = img9(mask ~= 255);
teste(:,10) = img10(mask ~= 255);
teste(:,11) = img11(mask ~= 255);
teste(:,12) = img12(mask ~= 255);
teste(:,13) = img13(mask ~= 255);
teste(:,14) = img14(mask ~= 255);
teste(:,15) = img15(mask ~= 255);
teste(:,16) = img16(mask ~= 255);

indices = find(mask ~= 255);

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);

saida = zeros(size(img1));
saida(indices(classificacao ~= 1)) = 255;

imwrite(saida,'saida.bmp','BMP');

