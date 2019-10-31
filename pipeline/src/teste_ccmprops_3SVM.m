function teste_ccmprops_3SVM

img = imread('emily3.tif');
img_t = imread('emily1.tif');
imgI = mat2gray(img);
img_tI = mat2gray(img_t);

mask = imread('emily3_mask_4class.bmp');
mask_t = imread('emily1_mask_4class.bmp');

janela = 9;

%
% MASSA BRANCA
%
indices = find(mask == 178); %WM

len = size(indices,1); %total de pixeis da mascara

treino_wm = zeros(len,1);

%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),imgI,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,1) = tmp.Contrast;      
    %treino(t,1) = tmp.Energy;
    %treino_wm(t,1) = tmp.Homogeneity;    
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,2) = tmp.Contrast;    
    %treino(t,2) = tmp.Energy;
    %treino_wm(t,2) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    %treino(t,5) = tmp.Contrast;    
    %treino(t,5) = tmp.Energy;
    %treino_wm(t,3) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,7) = tmp.Contrast;    
    %treino(t,4) = tmp.Energy;
    %treino_wm(t,4) = tmp.Homogeneity;    
    
    treino_wm(t,1) = imgI(indices(t));    
end

labels_wm = ones(len,1);

model_wm = svmtrain(labels_wm,treino_wm,'-s 2 -t 2 -n 0.4'); %treina

%
% MASSA CINZA
%
indices = find(mask == 153); %GM

len = size(indices,1); %total de pixeis da mascara

treino_gm = zeros(len,1);

%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),imgI,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,1) = tmp.Contrast;      
    %treino(t,1) = tmp.Energy;
    %treino_gm(t,1) = tmp.Homogeneity;    
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,2) = tmp.Contrast;    
    %treino(t,2) = tmp.Energy;
    %treino_gm(t,2) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    %treino(t,5) = tmp.Contrast;    
    %treino(t,5) = tmp.Energy;
    %treino_gm(t,3) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,7) = tmp.Contrast;    
    %treino(t,4) = tmp.Energy;
    %treino_gm(t,4) = tmp.Homogeneity;    
    
    treino_gm(t,1) = imgI(indices(t));    
end

labels_gm = ones(len,1);

model_gm = svmtrain(labels_gm,treino_gm,'-s 2 -t 2 -n 0.4'); %treina

%
% LIQUOR
%
indices = find(mask == 0); %CSF

len = size(indices,1); %total de pixeis da mascara

treino_csf = zeros(len,1);

%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),imgI,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,1) = tmp.Contrast;      
    %treino(t,1) = tmp.Energy;
    %treino_csf(t,1) = tmp.Homogeneity;    
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,2) = tmp.Contrast;    
    %treino(t,2) = tmp.Energy;
    %treino_csf(t,2) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    %treino(t,5) = tmp.Contrast;    
    %treino(t,5) = tmp.Energy;
    %treino_csf(t,3) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    %treino(t,7) = tmp.Contrast;    
    %treino(t,4) = tmp.Energy;
    %treino_csf(t,4) = tmp.Homogeneity;    
    
    treino_csf(t,1) = imgI(indices(t));    
end

labels_csf = ones(len,1);

model_csf = svmtrain(labels_csf,treino_csf,'-s 2 -t 2 -n 0.4'); %treina


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
saida = zeros(size(img_t));

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model_wm); %classifica WM
saida(indices2(classificacao == 1)) = 200;

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model_gm); %classifica GM
saida(indices2(classificacao == 1)) = 150;

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model_csf); %classifica CSF
saida(indices2(classificacao == 1)) = 90;

imwrite(gscale(saida),'saida_3svm.bmp','BMP');