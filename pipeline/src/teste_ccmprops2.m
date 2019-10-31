function teste_ccmprops2()

textura1 = imread('texturas/texture-05-gry.jpg');
textura2 = imread('texturas/texture-08-gry.jpg');
textura3 = imread('texturas/texture-09-gry.jpg');
textura4 = imread('texturas/texture-10-gry.jpg');
textura_teste = imread('texturas/texture_teste1.jpg');

textura1 = mat2gray(textura1);
textura2 = mat2gray(textura2);
textura3 = mat2gray(textura3);
textura4 = mat2gray(textura4);
textura_teste = mat2gray(textura_teste);

quadrados1 = quadricula(textura1);
quadrados2 = quadricula(textura2);
quadrados3 = quadricula(textura3);
quadrados4 = quadricula(textura4);




%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    treino(t,1) = tmp.Contrast;  
    treino(t,2) = tmp.Correlation;
    treino(t,3) = tmp.Energy;
    treino(t,4) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    treino(t,5) = tmp.Contrast;
    treino(t,6) = tmp.Correlation;
    treino(t,7) = tmp.Energy;
    treino(t,8) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    treino(t,9) = tmp.Contrast;
    treino(t,10) = tmp.Correlation;
    treino(t,11) = tmp.Energy;
    treino(t,12) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    treino(t,13) = tmp.Contrast;
    treino(t,14) = tmp.Correlation;
    treino(t,15) = tmp.Energy;
    treino(t,16) = tmp.Homogeneity;    
end

labels = ones(len,1);

model = svmtrain(labels,treino,'-s 2 -t 2 -n 0.5'); %treina



indices2 = find(mask ~= 255);
len2 = size(indices2,1);

teste = zeros(len2,16);

%pega caracteristicas da img de teste
for t = 1:len2
    w = getwindow(indices2(t),img,janela);
    
    ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    teste(t,1) = tmp.Contrast;  
    teste(t,2) = tmp.Correlation;
    teste(t,3) = tmp.Energy;
    teste(t,4) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    teste(t,5) = tmp.Contrast;
    teste(t,6) = tmp.Correlation;
    teste(t,7) = tmp.Energy;
    teste(t,8) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 0],'Symmetric',true);      
    tmp = graycoprops(ccm,'All');
    teste(t,9) = tmp.Contrast;
    teste(t,10) = tmp.Correlation;
    teste(t,11) = tmp.Energy;
    teste(t,12) = tmp.Homogeneity;
    
    ccm = graycomatrix(w,'Offset',[-1 -1],'Symmetric',true);    
    tmp = graycoprops(ccm,'All');
    teste(t,13) = tmp.Contrast;
    teste(t,14) = tmp.Correlation;
    teste(t,15) = tmp.Energy;
    teste(t,16) = tmp.Homogeneity;      
end

labels_teste = ones(len2,1);

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);


saida = zeros(size(img));

saida(indices2(classificacao == 1)) = 255;

imwrite(saida,'saida.bmp','BMP');