function extract_textures2()

nome = 'vicenzo_data_geral.mat';

img_T1 = imread('vicenzo_T1.tif');
img_T1 = mat2gray(img_T1);

img_T1c = imread('vicenzo_T1c.tif');
img_T1c = mat2gray(img_T1c);

img_FLAIR = imread('vicenzo_FLAIR.tif');
img_FLAIR = mat2gray(img_FLAIR);

mask = imread('vicenzo_T1_mask_2class.bmp');


janela = 9;

%----------------------%
%         T1           %
%----------------------%

indices = find(mask ~= 255); %tudo

len = size(indices,1); %total de pixeis da mascara

struct.T1.ASM = zeros(len,4);
struct.T1.contrast = zeros(len,4);
struct.T1.correlation = zeros(len,4);
struct.T1.variance = zeros(len,4);
struct.T1.IDM = zeros(len,4);
struct.T1.sum_average = zeros(len,4);
struct.T1.sum_variance = zeros(len,4);
struct.T1.sum_entropy = zeros(len,4);
struct.T1.entropy = zeros(len,4);
struct.T1.diff_variance = zeros(len,4);
struct.T1.diff_entropy = zeros(len,4);
struct.T1.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1.intensity(t) = img_T1(indices(t));
end


%----------------------%
%         T1C          %
%----------------------%


indices = find(mask ~= 255); %WM

len = size(indices,1); %total de pixeis da mascara

struct.T1c.ASM = zeros(len,4);
struct.T1c.contrast = zeros(len,4);
struct.T1c.correlation = zeros(len,4);
struct.T1c.variance = zeros(len,4);
struct.T1c.IDM = zeros(len,4);
struct.T1c.sum_average = zeros(len,4);
struct.T1c.sum_variance = zeros(len,4);
struct.T1c.sum_entropy = zeros(len,4);
struct.T1c.entropy = zeros(len,4);
struct.T1c.diff_variance = zeros(len,4);
struct.T1c.diff_entropy = zeros(len,4);
struct.T1c.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1c,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1c.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1c.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1c.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1c.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1c.intensity(t) = img_T1c(indices(t));

end



%----------------------%
%        FLAIR         %
%----------------------%


indices = find(mask ~= 255); %tudo

len = size(indices,1); %total de pixeis da mascara

struct.FLAIR.ASM = zeros(len,4);
struct.FLAIR.contrast = zeros(len,4);
struct.FLAIR.correlation = zeros(len,4);
struct.FLAIR.variance = zeros(len,4);
struct.FLAIR.IDM = zeros(len,4);
struct.FLAIR.sum_average = zeros(len,4);
struct.FLAIR.sum_variance = zeros(len,4);
struct.FLAIR.sum_entropy = zeros(len,4);
struct.FLAIR.entropy = zeros(len,4);
struct.FLAIR.diff_variance = zeros(len,4);
struct.FLAIR.diff_entropy = zeros(len,4);
struct.FLAIR.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_FLAIR,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.FLAIR.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.FLAIR.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.FLAIR.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.FLAIR.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.FLAIR.intensity(t) = img_FLAIR(indices(t));

end


save(nome,'struct');




%===================
%
% AURORA 
%
%===================




nome = 'aurora_data_geral.mat';

img_T1 = imread('aurora_T1.tif');
img_T1 = mat2gray(img_T1);

img_T1c = imread('aurora_T1c.tif');
img_T1c = mat2gray(img_T1c);

img_FLAIR = imread('aurora_FLAIR.tif');
img_FLAIR = mat2gray(img_FLAIR);

mask = imread('aurora_T1_mask_2class.bmp');


janela = 9;


%----------------------%
%         T1           %
%----------------------%


indices = find(mask ~= 255); %tudo

len = size(indices,1); %total de pixeis da mascara

struct.T1.ASM = zeros(len,4);
struct.T1.contrast = zeros(len,4);
struct.T1.correlation = zeros(len,4);
struct.T1.variance = zeros(len,4);
struct.T1.IDM = zeros(len,4);
struct.T1.sum_average = zeros(len,4);
struct.T1.sum_variance = zeros(len,4);
struct.T1.sum_entropy = zeros(len,4);
struct.T1.entropy = zeros(len,4);
struct.T1.diff_variance = zeros(len,4);
struct.T1.diff_entropy = zeros(len,4);
struct.T1.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1.intensity(t) = img_T1(indices(t));

end


%----------------------%
%         T1C          %
%----------------------%


indices = find(mask ~= 255); %tudo

len = size(indices,1); %total de pixeis da mascara

struct.T1c.ASM = zeros(len,4);
struct.T1c.contrast = zeros(len,4);
struct.T1c.correlation = zeros(len,4);
struct.T1c.variance = zeros(len,4);
struct.T1c.IDM = zeros(len,4);
struct.T1c.sum_average = zeros(len,4);
struct.T1c.sum_variance = zeros(len,4);
struct.T1c.sum_entropy = zeros(len,4);
struct.T1c.entropy = zeros(len,4);
struct.T1c.diff_variance = zeros(len,4);
struct.T1c.diff_entropy = zeros(len,4);
struct.T1c.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1c,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1c.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1c.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1c.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1c.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1c.intensity(t) = img_T1c(indices(t));

end


%----------------------%
%        FLAIR         %
%----------------------%


indices = find(mask ~= 255); %tudo

len = size(indices,1); %total de pixeis da mascara

struct.FLAIR.ASM = zeros(len,4);
struct.FLAIR.contrast = zeros(len,4);
struct.FLAIR.correlation = zeros(len,4);
struct.FLAIR.variance = zeros(len,4);
struct.FLAIR.IDM = zeros(len,4);
struct.FLAIR.sum_average = zeros(len,4);
struct.FLAIR.sum_variance = zeros(len,4);
struct.FLAIR.sum_entropy = zeros(len,4);
struct.FLAIR.entropy = zeros(len,4);
struct.FLAIR.diff_variance = zeros(len,4);
struct.FLAIR.diff_entropy = zeros(len,4);
struct.FLAIR.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_FLAIR,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.FLAIR.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.FLAIR.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.FLAIR.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.FLAIR.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.FLAIR.intensity(t) = img_FLAIR(indices(t));

end


save(nome,'struct');

