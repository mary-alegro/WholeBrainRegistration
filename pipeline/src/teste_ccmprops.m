function teste_ccmprops

img = imread('emily3.tif');
img_t = imread('emily4.tif');
%img = gscale(dicomread('emilyT1_3.dcm'));
imgI = mat2gray(img);
img_tI = mat2gray(img_t);

mask = imread('emily3_mask_2class.bmp');
mask_t = imread('emily4_mask_2class.bmp');

indices = find(mask == 242); %area de tumor

len = size(indices,1); %total de pixeis da mascara

treino = zeros(len,5);

janela = 9;

%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),imgI,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,1) = tmp.Contrast;      
    %treino(t,1) = tmp.Energy;
    treino(t,1) = tmp.Homogeneity;    
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,2) = tmp.Contrast;    
    %treino(t,2) = tmp.Energy;
    treino(t,2) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    %treino(t,5) = tmp.Contrast;    
    %treino(t,5) = tmp.Energy;
    treino(t,3) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,7) = tmp.Contrast;    
    %treino(t,4) = tmp.Energy;
    treino(t,4) = tmp.Homogeneity;    
    
    treino(t,5) = imgI(indices(t));    
end

labels = ones(len,1);

model = svmtrain(labels,treino,'-s 2 -t 2 -n 0.4'); %treina



indices2 = find(mask_t ~= 255);
len2 = size(indices2,1);

teste = zeros(len2,5);

%pega caracteristicas da img de teste
for t = 1:len2
    w = getwindow(indices2(t),img_tI,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %teste(t,1) = tmp.Contrast;      
    %teste(t,1) = tmp.Energy;
    teste(t,1) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %teste(t,3) = tmp.Contrast;    
    %teste(t,2) = tmp.Energy;
    teste(t,2) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    %teste(t,5) = tmp.Contrast;    
    %teste(t,3) = tmp.Energy;
    teste(t,3) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %teste(t,7) = tmp.Contrast;    
    %teste(t,4) = tmp.Energy;
    teste(t,4) = tmp.Homogeneity;     
    
    teste(t,5) = img_tI(indices2(t));    
end

labels_teste = zeros(len2,1);

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);


saida = zeros(size(img_t));

saida(indices2(classificacao == 1)) = 255;

imwrite(gscale(saida),'saida.bmp','BMP');