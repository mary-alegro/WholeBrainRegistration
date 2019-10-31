function teste_ccmprops_4class()

img = imread('emily3.tif');
img_t = imread('emily3.tif');
%img = gscale(dicomread('emilyT1_3.dcm'));
imgI = mat2gray(img);
img_tI = mat2gray(img_t);

mask = imread('emily3_mask_4class.bmp');
mask_t = imread('emily3_mask_4class.bmp');

WM = find(mask == 178); %white matter
GM = find(mask == 153); %gray matter
liquor = find(mask == 0); %CSF

janela = 9;

%
% WM 
%
len = size(WM,1); %total de pixeis da mascara

treino1 = zeros(len,5);

labels1 = ones(len,1);

%pega caracteristicas da massa branca
for t = 1:len
    w = getwindow(WM(t),imgI,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,1) = tmp.Contrast;      
    %treino(t,1) = tmp.Energy;
    treino1(t,1) = tmp.Homogeneity;    
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,2) = tmp.Contrast;    
    %treino(t,2) = tmp.Energy;
    treino1(t,2) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    %treino(t,5) = tmp.Contrast;    
    %treino(t,5) = tmp.Energy;
    treino1(t,3) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,7) = tmp.Contrast;    
    %treino(t,4) = tmp.Energy;
    treino1(t,4) = tmp.Homogeneity;    
    
    treino1(t,5) = imgI(WM(t));   
    
    labels1(t) = 1;
end


len = size(GM,1); %total de pixeis da mascara

treino2 = zeros(len,5);

labels2 = ones(len,1);

%pega caracteristicas da massa cinza
for t = 1:len
    w = getwindow(GM(t),imgI,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,1) = tmp.Contrast;      
    %treino(t,1) = tmp.Energy;
    treino2(t,1) = tmp.Homogeneity;    
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,2) = tmp.Contrast;    
    %treino(t,2) = tmp.Energy;
    treino2(t,2) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    %treino(t,5) = tmp.Contrast;    
    %treino(t,5) = tmp.Energy;
    treino2(t,3) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,7) = tmp.Contrast;    
    %treino(t,4) = tmp.Energy;
    treino2(t,4) = tmp.Homogeneity;    
    
    treino2(t,5) = imgI(GM(t));   
    
    labels2(t) = 2;
end

len = size(liquor,1); %total de pixeis da mascara

treino3 = zeros(len,5);

labels3 = ones(len,1);

%pega caracteristicas do liquor
for t = 1:len
    w = getwindow(liquor(t),imgI,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,1) = tmp.Contrast;      
    %treino(t,1) = tmp.Energy;
    treino3(t,1) = tmp.Homogeneity;    
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,2) = tmp.Contrast;    
    %treino(t,2) = tmp.Energy;
    treino3(t,2) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    %treino(t,5) = tmp.Contrast;    
    %treino(t,5) = tmp.Energy;
    treino3(t,3) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,7) = tmp.Contrast;    
    %treino(t,4) = tmp.Energy;
    treino3(t,4) = tmp.Homogeneity;    
    
    treino3(t,5) = imgI(liquor(t));   
    
    labels3(t) = 3;
end

treino = [treino1; treino2; treino3];
labels = [labels1; labels2; labels3];


%
% TREINO
%

model = svmtrain(labels,treino,'-c 1 -g 2 -b 1'); %treina


%
% TESTE
%

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


saida = ones(size(img_t));

saida(indices2(classificacao == 1)) = 90;
saida(indices2(classificacao == 2)) = 120;
saida(indices2(classificacao == 3)) = 190;


imwrite(gscale(saida),'saida3.bmp','BMP');