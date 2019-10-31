function [struct] = extrai_haralick(img_strut)
                                   
 %
 % Extrai dados de textura descritos no trabalho de haralick
 %
 
img_T1_1 = img_strut.T1(:,:,1);
img_T1_2 = img_strut.T1(:,:,2);
img_T1_3 = img_strut.T1(:,:,3);
img_T1c_1 = img_strut.T1c(:,:,1);
img_T1c_2 = img_strut.T1c(:,:,2);
img_T1c_3 = img_strut.T1c(:,:,3);
img_FLAIR_1 = img_strut.FLAIR(:,:,1);
img_FLAIR_2 = img_strut.FLAIR(:,:,2);
img_FLAIR_3 = img_strut.FLAIR(:,:,3);
mask1 = img_strut.mask(:,:,1);
mask2 = img_strut.mask(:,:,2);
mask3 = img_strut.mask(:,:,3);


janela = 9;

indices1 = find(mask1 ~= 0); %tudo
indices2 = find(mask2 ~= 0);
indices3 = find(mask3 ~= 0);

len1 = size(indices1,1); %total de pixeis da mascara
len2 = size(indices2,1);
len3 = size(indices3,1);

struct = incializa_ed(len1,len2,len3); %inicializa estrutura de dados

fprintf('Iniciando calculo das texturas por Matriz de Co-ocorrencia (Haralick)...\n');

%-------------------------------------------------------------------------%
%                               SLICE 1                                   %
%-------------------------------------------------------------------------%

disp('Processando Slice 1...');


%----------------------%
%         T1           %
%----------------------%

nErros = 0;
%pega caracteristicas da imagem 1
for t = 1:len1
    try
        w = getwindow(indices1(t),img_T1_1,janela);
    catch
        nErros = nErros+1;
        continue;
    end
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1.s1.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s1.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s1.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s1.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s1.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s1.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s1.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s1.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s1.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s1.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s1.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1.s1.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s1.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s1.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s1.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s1.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s1.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s1.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s1.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s1.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s1.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s1.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1.s1.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s1.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s1.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s1.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s1.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s1.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s1.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s1.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s1.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s1.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s1.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1.s1.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s1.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s1.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s1.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s1.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s1.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s1.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s1.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s1.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s1.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s1.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1.s1.intensity(t) = img_T1_1(indices1(t));
end

disp(strcat('Num. Erros T1: ',int2str(nErros)));

%----------------------%
%         T1C          %
%----------------------%


%pega caracteristicas
nErros = 0;
for t = 1:len1
    try
        w = getwindow(indices1(t),img_T1c_1,janela);
    catch
        nErros = nErros+1;
        continue;
    end
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1c.s1.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s1.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s1.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s1.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s1.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s1.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s1.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s1.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s1.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s1.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s1.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1c.s1.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s1.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s1.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s1.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s1.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s1.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s1.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s1.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s1.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s1.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s1.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1c.s1.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s1.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s1.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s1.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s1.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s1.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s1.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s1.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s1.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s1.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s1.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1c.s1.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s1.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s1.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s1.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s1.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s1.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s1.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s1.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s1.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s1.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s1.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1c.s1.intensity(t) = img_T1c_1(indices1(t));

end

disp(strcat('Num. Erros T1c: ',int2str(nErros)));

%----------------------%
%        FLAIR         %
%----------------------%

nErros = 0;
%pega caracteristicas
for t = 1:len1
    try
        w = getwindow(indices1(t),img_FLAIR_1,janela);
    catch
        nErros = nErros+1;
        continue;
    end
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.FLAIR.s1.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s1.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s1.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s1.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s1.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s1.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s1.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s1.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s1.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s1.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s1.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.FLAIR.s1.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s1.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s1.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s1.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s1.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s1.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s1.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s1.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s1.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s1.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s1.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.FLAIR.s1.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s1.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s1.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s1.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s1.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s1.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s1.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s1.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s1.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s1.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s1.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.FLAIR.s1.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s1.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s1.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s1.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s1.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s1.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s1.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s1.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s1.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s1.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s1.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.FLAIR.s1.intensity(t) = img_FLAIR_1(indices1(t));

end

disp(strcat('Num. Erros FLAIR: ',int2str(nErros)));




%-------------------------------------------------------------------------%
%                               SLICE 2                                   %
%-------------------------------------------------------------------------%

disp('Processando Slice 2...');

%----------------------%
%         T1           %
%----------------------%

nErros = 0;
%pega caracteristicas da imagem 1
for t = 1:len2
    try        
        w = getwindow(indices2(t),img_T1_2,janela);
    catch
        nErros = nErros+1;
        continue;
    end
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1.s2.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s2.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s2.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s2.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s2.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s2.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s2.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s2.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s2.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s2.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s2.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1.s2.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s2.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s2.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s2.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s2.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s2.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s2.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s2.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s2.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s2.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s2.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1.s2.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s2.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s2.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s2.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s2.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s2.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s2.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s2.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s2.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s2.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s2.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1.s2.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s2.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s2.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s2.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s2.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s2.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s2.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s2.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s2.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s2.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s2.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1.s2.intensity(t) = img_T1_2(indices2(t));
end
disp(strcat('Num. Erros T1: ',int2str(nErros)));


%----------------------%
%         T1C          %
%----------------------%

nErros = 0;
%pega caracteristicas
for t = 1:len2
    try
        w = getwindow(indices2(t),img_T1c_2,janela);
    catch
        nErros = nErros+1;
        continue;
    end
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1c.s2.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s2.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s2.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s2.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s2.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s2.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s2.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s2.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s2.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s2.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s2.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1c.s2.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s2.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s2.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s2.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s2.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s2.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s2.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s2.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s2.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s2.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s2.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1c.s2.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s2.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s2.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s2.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s2.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s2.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s2.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s2.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s2.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s2.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s2.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1c.s2.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s2.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s2.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s2.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s2.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s2.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s2.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s2.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s2.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s2.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s2.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1c.s2.intensity(t) = img_T1c_2(indices2(t));

end
disp(strcat('Num. Erros T1c: ',int2str(nErros)));


%----------------------%
%        FLAIR         %
%----------------------%

nErros = 0;
%pega caracteristicas
for t = 1:len2
    try
        w = getwindow(indices2(t),img_FLAIR_2,janela);
    catch
        nErros = nErros+1;
        continue;
    end
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.FLAIR.s2.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s2.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s2.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s2.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s2.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s2.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s2.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s2.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s2.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s2.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s2.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.FLAIR.s2.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s2.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s2.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s2.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s2.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s2.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s2.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s2.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s2.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s2.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s2.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.FLAIR.s2.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s2.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s2.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s2.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s2.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s2.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s2.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s2.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s2.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s2.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s2.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.FLAIR.s2.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s2.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s2.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s2.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s2.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s2.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s2.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s2.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s2.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s2.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s2.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.FLAIR.s2.intensity(t) = img_FLAIR_2(indices2(t));

end
disp(strcat('Num. Erros FLAIR: ',int2str(nErros)));





%-------------------------------------------------------------------------%
%                               SLICE 3                                   %
%-------------------------------------------------------------------------%

disp('Processando Slice 3...');

%----------------------%
%         T1           %
%----------------------%

nErros = 0;
%pega caracteristicas da imagem 1
for t = 1:len3
    try
        w = getwindow(indices3(t),img_T1_3,janela);
    catch
        nErros = nErros+1;
        continue;
    end
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1.s3.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s3.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s3.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s3.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s3.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s3.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s3.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s3.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s3.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s3.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s3.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1.s3.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s3.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s3.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s3.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s3.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s3.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s3.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s3.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s3.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s3.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s3.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1.s3.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s3.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s3.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s3.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s3.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s3.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s3.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s3.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s3.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s3.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s3.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1.s3.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.s3.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.s3.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.s3.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1.s3.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.s3.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.s3.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.s3.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.s3.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.s3.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.s3.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1.s3.intensity(t) = img_T1_3(indices3(t));
end
disp(strcat('Num. Erros T1: ',int2str(nErros)));


%----------------------%
%         T1C          %
%----------------------%

nErros = 0;
%pega caracteristicas
for t = 1:len3
    try
        w = getwindow(indices3(t),img_T1c_3,janela);
    catch
        nErros = nErros+1;
        continue;
    end
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1c.s3.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s3.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s3.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s3.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s3.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s3.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s3.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s3.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s3.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s3.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s3.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1c.s3.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s3.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s3.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s3.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s3.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s3.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s3.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s3.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s3.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s3.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s3.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1c.s3.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s3.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s3.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s3.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s3.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s3.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s3.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s3.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s3.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s3.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s3.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1c.s3.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.s3.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.s3.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.s3.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.s3.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.s3.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.s3.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.s3.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.s3.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.s3.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.s3.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1c.s3.intensity(t) = img_T1c_3(indices3(t));

end
disp(strcat('Num. Erros T1c: ',int2str(nErros)));


%----------------------%
%        FLAIR         %
%----------------------%

nErros = 0;
%pega caracteristicas
for t = 1:len3
    try
        w = getwindow(indices3(t),img_FLAIR_3,janela);
    catch
        nErros = nErros+1;
        continue;
    end
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.FLAIR.s3.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s3.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s3.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s3.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s3.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s3.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s3.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s3.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s3.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s3.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s3.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.FLAIR.s3.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s3.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s3.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s3.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s3.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s3.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s3.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s3.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s3.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s3.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s3.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.FLAIR.s3.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s3.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s3.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s3.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s3.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s3.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s3.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s3.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s3.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s3.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s3.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.FLAIR.s3.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.s3.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.s3.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.s3.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.s3.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.s3.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.s3.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.s3.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.s3.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.s3.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.s3.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.FLAIR.s3.intensity(t) = img_FLAIR_3(indices3(t));

end
disp(strcat('Num. Erros FLAIR: ',int2str(nErros)));




%%%%%%%%%%%%%%%%%%%%%%%



function struct = incializa_ed(len1,len2,len3)

    %
    % T1
    %
    
    %slice 1    
    struct.T1.s1.ASM = zeros(len1,4);
    struct.T1.s1.contrast = zeros(len1,4);
    struct.T1.s1.correlation = zeros(len1,4);
    struct.T1.s1.variance = zeros(len1,4);
    struct.T1.s1.IDM = zeros(len1,4);
    struct.T1.s1.sum_average = zeros(len1,4);
    struct.T1.s1.sum_variance = zeros(len1,4);
    struct.T1.s1.sum_entropy = zeros(len1,4);
    struct.T1.s1.entropy = zeros(len1,4);
    struct.T1.s1.diff_variance = zeros(len1,4);
    struct.T1.s1.diff_entropy = zeros(len1,4);
    struct.T1.s1.intensity = zeros(len1,1);
    
    %slice 2
    struct.T1.s2.ASM = zeros(len2,4);
    struct.T1.s2.contrast = zeros(len2,4);
    struct.T1.s2.correlation = zeros(len2,4);
    struct.T1.s2.variance = zeros(len2,4);
    struct.T1.s2.IDM = zeros(len2,4);
    struct.T1.s2.sum_average = zeros(len2,4);
    struct.T1.s2.sum_variance = zeros(len2,4);
    struct.T1.s2.sum_entropy = zeros(len2,4);
    struct.T1.s2.entropy = zeros(len2,4);
    struct.T1.s2.diff_variance = zeros(len2,4);
    struct.T1.s2.diff_entropy = zeros(len2,4);
    struct.T1.s2.intensity = zeros(len2,1);
    
    %slice 3
    struct.T1.s3.ASM = zeros(len3,4);
    struct.T1.s3.contrast = zeros(len3,4);
    struct.T1.s3.correlation = zeros(len3,4);
    struct.T1.s3.variance = zeros(len3,4);
    struct.T1.s3.IDM = zeros(len3,4);
    struct.T1.s3.sum_average = zeros(len3,4);
    struct.T1.s3.sum_variance = zeros(len3,4);
    struct.T1.s3.sum_entropy = zeros(len3,4);
    struct.T1.s3.entropy = zeros(len3,4);
    struct.T1.s3.diff_variance = zeros(len3,4);
    struct.T1.s3.diff_entropy = zeros(len3,4);
    struct.T1.s3.intensity = zeros(len3,1);
    
    
    %
    % T1c
    %
    
    %slice 1    
    struct.T1c.s1.ASM = zeros(len1,4);
    struct.T1c.s1.contrast = zeros(len1,4);
    struct.T1c.s1.correlation = zeros(len1,4);
    struct.T1c.s1.variance = zeros(len1,4);
    struct.T1c.s1.IDM = zeros(len1,4);
    struct.T1c.s1.sum_average = zeros(len1,4);
    struct.T1c.s1.sum_variance = zeros(len1,4);
    struct.T1c.s1.sum_entropy = zeros(len1,4);
    struct.T1c.s1.entropy = zeros(len1,4);
    struct.T1c.s1.diff_variance = zeros(len1,4);
    struct.T1c.s1.diff_entropy = zeros(len1,4);
    struct.T1c.s1.intensity = zeros(len1,1);
    
    %slice 2
    struct.T1c.s2.ASM = zeros(len2,4);
    struct.T1c.s2.contrast = zeros(len2,4);
    struct.T1c.s2.correlation = zeros(len2,4);
    struct.T1c.s2.variance = zeros(len2,4);
    struct.T1c.s2.IDM = zeros(len2,4);
    struct.T1c.s2.sum_average = zeros(len2,4);
    struct.T1c.s2.sum_variance = zeros(len2,4);
    struct.T1c.s2.sum_entropy = zeros(len2,4);
    struct.T1c.s2.entropy = zeros(len2,4);
    struct.T1c.s2.diff_variance = zeros(len2,4);
    struct.T1c.s2.diff_entropy = zeros(len2,4);
    struct.T1c.s2.intensity = zeros(len2,1);
    
    %slice 3
    struct.T1c.s3.ASM = zeros(len3,4);
    struct.T1c.s3.contrast = zeros(len3,4);
    struct.T1c.s3.correlation = zeros(len3,4);
    struct.T1c.s3.variance = zeros(len3,4);
    struct.T1c.s3.IDM = zeros(len3,4);
    struct.T1c.s3.sum_average = zeros(len3,4);
    struct.T1c.s3.sum_variance = zeros(len3,4);
    struct.T1c.s3.sum_entropy = zeros(len3,4);
    struct.T1c.s3.entropy = zeros(len3,4);
    struct.T1c.s3.diff_variance = zeros(len3,4);
    struct.T1c.s3.diff_entropy = zeros(len3,4);
    struct.T1c.s3.intensity = zeros(len3,1);    
    
    
    %
    % FLAIR
    %
    
    %slice 1    
    struct.FLAIR.s1.ASM = zeros(len1,4);
    struct.FLAIR.s1.contrast = zeros(len1,4);
    struct.FLAIR.s1.correlation = zeros(len1,4);
    struct.FLAIR.s1.variance = zeros(len1,4);
    struct.FLAIR.s1.IDM = zeros(len1,4);
    struct.FLAIR.s1.sum_average = zeros(len1,4);
    struct.FLAIR.s1.sum_variance = zeros(len1,4);
    struct.FLAIR.s1.sum_entropy = zeros(len1,4);
    struct.FLAIR.s1.entropy = zeros(len1,4);
    struct.FLAIR.s1.diff_variance = zeros(len1,4);
    struct.FLAIR.s1.diff_entropy = zeros(len1,4);
    struct.FLAIR.s1.intensity = zeros(len1,1);
    
    %slice 2
    struct.FLAIR.s2.ASM = zeros(len2,4);
    struct.FLAIR.s2.contrast = zeros(len2,4);
    struct.FLAIR.s2.correlation = zeros(len2,4);
    struct.FLAIR.s2.variance = zeros(len2,4);
    struct.FLAIR.s2.IDM = zeros(len2,4);
    struct.FLAIR.s2.sum_average = zeros(len2,4);
    struct.FLAIR.s2.sum_variance = zeros(len2,4);
    struct.FLAIR.s2.sum_entropy = zeros(len2,4);
    struct.FLAIR.s2.entropy = zeros(len2,4);
    struct.FLAIR.s2.diff_variance = zeros(len2,4);
    struct.FLAIR.s2.diff_entropy = zeros(len2,4);
    struct.FLAIR.s2.intensity = zeros(len2,1);
    
    %slice 3
    struct.FLAIR.s3.ASM = zeros(len3,4);
    struct.FLAIR.s3.contrast = zeros(len3,4);
    struct.FLAIR.s3.correlation = zeros(len3,4);
    struct.FLAIR.s3.variance = zeros(len3,4);
    struct.FLAIR.s3.IDM = zeros(len3,4);
    struct.FLAIR.s3.sum_average = zeros(len3,4);
    struct.FLAIR.s3.sum_variance = zeros(len3,4);
    struct.FLAIR.s3.sum_entropy = zeros(len3,4);
    struct.FLAIR.s3.entropy = zeros(len3,4);
    struct.FLAIR.s3.diff_variance = zeros(len3,4);
    struct.FLAIR.s3.diff_entropy = zeros(len3,4);
    struct.FLAIR.s3.intensity = zeros(len3,1);
    
    