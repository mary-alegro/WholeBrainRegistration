function teste_ccmprops_2class()

img = imread('emily3.tif');
img_t = imread('emily3.tif');
%img = gscale(dicomread('emilyT1_3.dcm'));
imgI = mat2gray(img);
img_tI = mat2gray(img_t);

mask = imread('emily3_mask_4class.bmp');
mask_t = imread('emily3_mask_4class.bmp');

cerebro = find(mask ~= 255 & mask ~= 229); %nao eh tumor nem fundo
tumor = find(mask == 229); %tumor

janela = 9;

%
% cerebro 
%
len = size(cerebro,1); %total de pixeis da mascara

treino1 = zeros(len,1);

labels1 = ones(len,1);

%pega caracteristicas do cerebro
for t = 1:len
    w = getwindow(cerebro(t),imgI,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,1) = tmp.Contrast;      
    %treino(t,1) = tmp.Energy;
    %treino1(t,1) = tmp.Homogeneity;    
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,2) = tmp.Contrast;    
    %treino(t,2) = tmp.Energy;
    %treino1(t,2) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    %treino(t,5) = tmp.Contrast;    
    %treino(t,5) = tmp.Energy;
    %treino1(t,3) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,7) = tmp.Contrast;    
    %treino(t,4) = tmp.Energy;
    %treino1(t,4) = tmp.Homogeneity;    
    
    treino1(t,1) = imgI(cerebro(t));   
    
    labels1(t) = -1;
end

len = size(tumor,1); %total de pixeis da mascara

treino2 = zeros(len,1);

labels2 = ones(len,1);

%pega caracteristicas do tumor
for t = 1:len
    w = getwindow(tumor(t),imgI,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,1) = tmp.Contrast;      
    %treino(t,1) = tmp.Energy;
    %treino2(t,1) = tmp.Homogeneity;    
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,2) = tmp.Contrast;    
    %treino(t,2) = tmp.Energy;
    %treino2(t,2) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    %treino(t,5) = tmp.Contrast;    
    %treino(t,5) = tmp.Energy;
    %treino2(t,3) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,7) = tmp.Contrast;    
    %treino(t,4) = tmp.Energy;
    %treino1(t,4) = tmp.Homogeneity;    
    
    treino2(t,1) = imgI(tumor(t));   
    
    labels2(t) = 1;
end

treino = [treino1; treino2;];
labels = [labels1; labels2;];


%
% TREINO
%

model = svmtrain(labels,treino,'-t 2 -w1 1 -w-1 100'); %treina


%
% TESTE
%

indices2 = find(mask_t ~= 255);
len2 = size(indices2,1);

teste = zeros(len2,1);

%pega caracteristicas da img de teste
for t = 1:len2
    w = getwindow(indices2(t),img_tI,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %teste(t,1) = tmp.Contrast;      
    %teste(t,1) = tmp.Energy;
    %teste(t,1) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %teste(t,3) = tmp.Contrast;    
    %teste(t,2) = tmp.Energy;
    %teste(t,2) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    %teste(t,5) = tmp.Contrast;    
    %teste(t,3) = tmp.Energy;
    %teste(t,3) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %teste(t,7) = tmp.Contrast;    
    %teste(t,4) = tmp.Energy;
    %teste(t,4) = tmp.Homogeneity;     
    
    teste(t,1) = img_tI(indices2(t));    
end

labels_teste = zeros(len2,1);

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);


saida = zeros(size(img_t));

saida(indices2(classificacao == -1)) = 128;
saida(indices2(classificacao == 1)) = 255;


imwrite(gscale(saida),'saida3.bmp','BMP');