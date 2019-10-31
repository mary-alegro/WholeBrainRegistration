function [FLAIR T1 T1c] = carrega_imagens

 flair_vol = zeros(256,256,11);
 t1_vol = zeros(256,256,11);
 t1c_vol = zeros(256,256,11);
 
 str = 'paciente';
 
 %FLAIR
 for i = 0:10
    nome = strcat(str,int2str(i),'/',str,int2str(i),'_FLAIR_N3Corrected.bmp');
    img = imread(nome);
    flair_vol(:,:,i+1) = img(:,:,1);
 end
 
 %T1
 for i = 0:10
    nome = strcat(str,int2str(i),'/',str,int2str(i),'_T1_N3Corrected.bmp');
    img = imread(nome);
    t1_vol(:,:,i+1) = img(:,:,1);
 end
 
 %T1c
 for i = 0:10
    nome = strcat(str,int2str(i),'/',str,int2str(i),'_T1c_N3Corrected.bmp');
    img = imread(nome);
    t1c_vol(:,:,i+1) = img(:,:,1);
 end
 
FLAIR = uint8(flair_vol);
T1 = uint8(t1_vol);
T1c = uint8(t1c_vol);