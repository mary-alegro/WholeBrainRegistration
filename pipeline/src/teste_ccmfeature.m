function teste_ccmfeature()

img = imread('vicenzo_T1.tif');
mask4class = imread('vicenzo_T1_mask_4class.bmp');

img_teste = imread('vicenzo_T1.tif');
mask2class_teste = imread('vicenzo_T1_mask_2class.bmp');

janela = 9;


%
% MASSA BRANCA
%
indices = find(mask4class == 204); %WM

len = size(indices,1); %total de pixeis da mascara

treino_wm = zeros(len,13);

%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    treino_wm(t,1) = grayccmfeatures(ccm_n,'ASM');
    treino_wm(t,2) = grayccmfeatures(ccm_n,'variance');
    %treino_wm(t,3) = grayccmfeatures(ccm_n,'IDM');
    %treino_wm(t,4) = grayccmfeatures(ccm_n,'sum_average');
    %treino_wm(t,5) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_wm(t,6) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_wm(t,3) = grayccmfeatures(ccm_n,'entropy');
    %treino_wm(t,8) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_wm(t,9) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    treino_wm(t,4) = grayccmfeatures(ccm_n,'ASM');
    treino_wm(t,5) = grayccmfeatures(ccm_n,'variance');
    %treino_wm(t,12) = grayccmfeatures(ccm_n,'IDM');
    %treino_wm(t,13) = grayccmfeatures(ccm_n,'sum_average');
    %treino_wm(t,14) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_wm(t,15) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_wm(t,6) = grayccmfeatures(ccm_n,'entropy');
    %treino_wm(t,17) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_wm(t,18) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    treino_wm(t,7) = grayccmfeatures(ccm_n,'ASM');
    treino_wm(t,8) = grayccmfeatures(ccm_n,'variance');
    %treino_wm(t,21) = grayccmfeatures(ccm_n,'IDM');
    %treino_wm(t,22) = grayccmfeatures(ccm_n,'sum_average');
    %treino_wm(t,23) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_wm(t,24) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_wm(t,9) = grayccmfeatures(ccm_n,'entropy');
    %treino_wm(t,26) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_wm(t,27) = grayccmfeatures(ccm_n,'diff_entropy');    
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    treino_wm(t,10) = grayccmfeatures(ccm_n,'ASM');
    treino_wm(t,11) = grayccmfeatures(ccm_n,'variance');
    %treino_wm(t,30) = grayccmfeatures(ccm_n,'IDM');
    %treino_wm(t,31) = grayccmfeatures(ccm_n,'sum_average');
    %treino_wm(t,32) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_wm(t,33) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_wm(t,12) = grayccmfeatures(ccm_n,'entropy');
    %treino_wm(t,35) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_wm(t,36) = grayccmfeatures(ccm_n,'diff_entropy');
    
    treino_wm(t,13) = img(indices(t));

end

labels_wm = ones(len,1);

model_wm = svmtrain(labels_wm,treino_wm,'-s 2 -t 2 -n 0.4'); %treina


%
% MASSA CINZENTA
%
indices = find(mask4class == 153); %GM

len = size(indices,1); %total de pixeis da mascara

treino_gm = zeros(len,13);

%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    treino_gm(t,1) = grayccmfeatures(ccm_n,'ASM');
    treino_gm(t,2) = grayccmfeatures(ccm_n,'variance');
    %treino_gm(t,3) = grayccmfeatures(ccm_n,'IDM');
    %treino_gm(t,4) = grayccmfeatures(ccm_n,'sum_average');
    %treino_gm(t,5) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_gm(t,6) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_gm(t,3) = grayccmfeatures(ccm_n,'entropy');
    %treino_gm(t,8) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_gm(t,9) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    treino_gm(t,4) = grayccmfeatures(ccm_n,'ASM');
    treino_gm(t,5) = grayccmfeatures(ccm_n,'variance');
    %treino_gm(t,12) = grayccmfeatures(ccm_n,'IDM');
    %treino_gm(t,13) = grayccmfeatures(ccm_n,'sum_average');
    %treino_gm(t,14) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_gm(t,15) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_gm(t,6) = grayccmfeatures(ccm_n,'entropy');
    %treino_gm(t,17) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_gm(t,18) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    treino_gm(t,7) = grayccmfeatures(ccm_n,'ASM');
    treino_gm(t,8) = grayccmfeatures(ccm_n,'variance');
    %treino_gm(t,21) = grayccmfeatures(ccm_n,'IDM');
    %treino_gm(t,22) = grayccmfeatures(ccm_n,'sum_average');
    %treino_gm(t,23) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_gm(t,24) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_gm(t,9) = grayccmfeatures(ccm_n,'entropy');
    %treino_gm(t,26) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_gm(t,27) = grayccmfeatures(ccm_n,'diff_entropy');    
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    treino_gm(t,10) = grayccmfeatures(ccm_n,'ASM');
    treino_gm(t,11) = grayccmfeatures(ccm_n,'variance');
    %treino_gm(t,30) = grayccmfeatures(ccm_n,'IDM');
    %treino_gm(t,31) = grayccmfeatures(ccm_n,'sum_average');
    %treino_gm(t,32) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_gm(t,33) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_gm(t,12) = grayccmfeatures(ccm_n,'entropy');
    %treino_gm(t,35) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_gm(t,36) = grayccmfeatures(ccm_n,'diff_entropy');
    
    treino_gm(t,13) = img(indices(t));

end

labels_gm = ones(len,1);

model_gm = svmtrain(labels_gm,treino_gm,'-s 2 -t 2 -n 0.4'); %treina


%
% LIQUOR
%
indices = find(mask4class == 76); %GM

len = size(indices,1); %total de pixeis da mascara

treino_csf = zeros(len,13);

%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    treino_csf(t,1) = grayccmfeatures(ccm_n,'ASM');
    treino_csf(t,2) = grayccmfeatures(ccm_n,'variance');
    %treino_csf(t,3) = grayccmfeatures(ccm_n,'IDM');
    %treino_csf(t,4) = grayccmfeatures(ccm_n,'sum_average');
    %treino_csf(t,5) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_csf(t,6) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_csf(t,3) = grayccmfeatures(ccm_n,'entropy');
    %treino_csf(t,8) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_csf(t,9) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    treino_csf(t,4) = grayccmfeatures(ccm_n,'ASM');
    treino_csf(t,5) = grayccmfeatures(ccm_n,'variance');
    %treino_csf(t,12) = grayccmfeatures(ccm_n,'IDM');
    %treino_csf(t,13) = grayccmfeatures(ccm_n,'sum_average');
    %treino_csf(t,14) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_csf(t,15) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_csf(t,6) = grayccmfeatures(ccm_n,'entropy');
    %treino_csf(t,17) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_csf(t,18) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    treino_csf(t,7) = grayccmfeatures(ccm_n,'ASM');
    treino_csf(t,8) = grayccmfeatures(ccm_n,'variance');
    %treino_csf(t,21) = grayccmfeatures(ccm_n,'IDM');
    %treino_csf(t,22) = grayccmfeatures(ccm_n,'sum_average');
    %treino_csf(t,23) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_csf(t,24) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_csf(t,9) = grayccmfeatures(ccm_n,'entropy');
    %treino_csf(t,26) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_csf(t,27) = grayccmfeatures(ccm_n,'diff_entropy');    
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    treino_csf(t,10) = grayccmfeatures(ccm_n,'ASM');
    treino_csf(t,11) = grayccmfeatures(ccm_n,'variance');
    %treino_csf(t,30) = grayccmfeatures(ccm_n,'IDM');
    %treino_csf(t,31) = grayccmfeatures(ccm_n,'sum_average');
    %treino_csf(t,32) = grayccmfeatures(ccm_n,'sum_variance');
    %treino_csf(t,33) = grayccmfeatures(ccm_n,'sum_entropy');
    treino_csf(t,12) = grayccmfeatures(ccm_n,'entropy');
    %treino_csf(t,35) = grayccmfeatures(ccm_n,'diff_variance');
    %treino_csf(t,36) = grayccmfeatures(ccm_n,'diff_entropy');
    
    treino_csf(t,13) = img(indices(t));

end

labels_csf = ones(len,1);

model_csf = svmtrain(labels_csf,treino_csf,'-s 2 -t 2 -n 0.4'); %treina


%
% TESTE
%

indices = find(mask2class_teste ~= 255); %GM

len = size(indices,1); %total de pixeis da mascara

teste = zeros(len,36);

%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_teste,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    teste(t,1) = grayccmfeatures(ccm_n,'ASM');
    teste(t,2) = grayccmfeatures(ccm_n,'variance');
    %teste(t,3) = grayccmfeatures(ccm_n,'IDM');
    %teste(t,4) = grayccmfeatures(ccm_n,'sum_average');
    %teste(t,5) = grayccmfeatures(ccm_n,'sum_variance');
    %teste(t,6) = grayccmfeatures(ccm_n,'sum_entropy');
    teste(t,3) = grayccmfeatures(ccm_n,'entropy');
    %teste(t,8) = grayccmfeatures(ccm_n,'diff_variance');
    %teste(t,9) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    teste(t,4) = grayccmfeatures(ccm_n,'ASM');
    teste(t,5) = grayccmfeatures(ccm_n,'variance');
    %teste(t,12) = grayccmfeatures(ccm_n,'IDM');
    %teste(t,13) = grayccmfeatures(ccm_n,'sum_average');
    %teste(t,14) = grayccmfeatures(ccm_n,'sum_variance');
    %teste(t,15) = grayccmfeatures(ccm_n,'sum_entropy');
    teste(t,6) = grayccmfeatures(ccm_n,'entropy');
    %teste(t,17) = grayccmfeatures(ccm_n,'diff_variance');
    %teste(t,18) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    teste(t,7) = grayccmfeatures(ccm_n,'ASM');
    teste(t,8) = grayccmfeatures(ccm_n,'variance');
    %teste(t,21) = grayccmfeatures(ccm_n,'IDM');
    %teste(t,22) = grayccmfeatures(ccm_n,'sum_average');
    %teste(t,23) = grayccmfeatures(ccm_n,'sum_variance');
    %teste(t,24) = grayccmfeatures(ccm_n,'sum_entropy');
    teste(t,9) = grayccmfeatures(ccm_n,'entropy');
    %teste(t,26) = grayccmfeatures(ccm_n,'diff_variance');
    %teste(t,27) = grayccmfeatures(ccm_n,'diff_entropy');    
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    teste(t,10) = grayccmfeatures(ccm_n,'ASM');
    teste(t,11) = grayccmfeatures(ccm_n,'variance');
    %teste(t,30) = grayccmfeatures(ccm_n,'IDM');
    %teste(t,31) = grayccmfeatures(ccm_n,'sum_average');
    %teste(t,32) = grayccmfeatures(ccm_n,'sum_variance');
    %teste(t,33) = grayccmfeatures(ccm_n,'sum_entropy');
    teste(t,12) = grayccmfeatures(ccm_n,'entropy');
    %teste(t,35) = grayccmfeatures(ccm_n,'diff_variance');
    %teste(t,36) = grayccmfeatures(ccm_n,'diff_entropy');
    
    teste(t,13) = img_teste(indices(t));

end

labels_teste = zeros(len,1);
saida = zeros(size(img_teste));

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model_wm); %classifica WM
saida(indices(classificacao == 1)) = 200;

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model_gm); %classifica GM
saida(indices(classificacao == 1)) = 150;

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model_csf); %classifica CSF
saida(indices(classificacao == 1)) = 90;

imwrite(gscale(saida),'saida_haralick.bmp','BMP');