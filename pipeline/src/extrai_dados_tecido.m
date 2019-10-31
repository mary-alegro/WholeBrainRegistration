function [struct] = extrai_dados_tecido(img_T1,img_T1c,img_FLAIR,mask)


janela = 9;

%----------------------%
%         T1           %
%----------------------%

%
% MASSA BRANCA
%
indices = find(mask == 204); %WM

len = size(indices,1); %total de pixeis da mascara

struct.T1.WM.ASM = zeros(len,4);
struct.T1.WM.contrast = zeros(len,4);
struct.T1.WM.correlation = zeros(len,4);
struct.T1.WM.variance = zeros(len,4);
struct.T1.WM.IDM = zeros(len,4);
struct.T1.WM.sum_average = zeros(len,4);
struct.T1.WM.sum_variance = zeros(len,4);
struct.T1.WM.sum_entropy = zeros(len,4);
struct.T1.WM.entropy = zeros(len,4);
struct.T1.WM.diff_variance = zeros(len,4);
struct.T1.WM.diff_entropy = zeros(len,4);
struct.T1.WM.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1.WM.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.WM.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.WM.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.WM.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1.WM.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.WM.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.WM.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.WM.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.WM.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.WM.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.WM.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1.WM.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.WM.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.WM.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.WM.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1.WM.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.WM.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.WM.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.WM.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.WM.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.WM.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.WM.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1.WM.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.WM.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.WM.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.WM.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1.WM.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.WM.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.WM.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.WM.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.WM.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.WM.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.WM.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1.WM.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.WM.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.WM.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.WM.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1.WM.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.WM.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.WM.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.WM.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.WM.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.WM.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.WM.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1.WM.intensity(t) = img_T1(indices(t));

end

%
% MASSA CINZENTA
%
indices = find(mask == 153); %GM

len = size(indices,1); %total de pixeis da mascara

struct.T1.GM.ASM = zeros(len,4);
struct.T1.GM.contrast = zeros(len,4);
struct.T1.GM.correlation = zeros(len,4);
struct.T1.GM.variance = zeros(len,4);
struct.T1.GM.IDM = zeros(len,4);
struct.T1.GM.sum_average = zeros(len,4);
struct.T1.GM.sum_variance = zeros(len,4);
struct.T1.GM.sum_entropy = zeros(len,4);
struct.T1.GM.entropy = zeros(len,4);
struct.T1.GM.diff_variance = zeros(len,4);
struct.T1.GM.diff_entropy = zeros(len,4);
struct.T1.GM.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1.GM.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.GM.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.GM.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.GM.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1.GM.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.GM.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.GM.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.GM.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.GM.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.GM.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.GM.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1.GM.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.GM.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.GM.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.GM.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1.GM.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.GM.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.GM.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.GM.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.GM.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.GM.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.GM.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1.GM.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.GM.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.GM.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.GM.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1.GM.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.GM.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.GM.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.GM.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.GM.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.GM.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.GM.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1.GM.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.GM.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.GM.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.GM.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1.GM.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.GM.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.GM.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.GM.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.GM.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.GM.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.GM.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1.GM.intensity(t) = img_T1(indices(t));

end


%
% LIQUOR
%
indices = find(mask == 76); %CSF

len = size(indices,1); %total de pixeis da mascara

struct.T1.CSF.ASM = zeros(len,4);
struct.T1.CSF.contrast = zeros(len,4);
struct.T1.CSF.correlation = zeros(len,4);
struct.T1.CSF.variance = zeros(len,4);
struct.T1.CSF.IDM = zeros(len,4);
struct.T1.CSF.sum_average = zeros(len,4);
struct.T1.CSF.sum_variance = zeros(len,4);
struct.T1.CSF.sum_entropy = zeros(len,4);
struct.T1.CSF.entropy = zeros(len,4);
struct.T1.CSF.diff_variance = zeros(len,4);
struct.T1.CSF.diff_entropy = zeros(len,4);
struct.T1.CSF.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1.CSF.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.CSF.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.CSF.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.CSF.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1.CSF.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.CSF.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.CSF.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.CSF.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.CSF.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.CSF.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.CSF.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1.CSF.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.CSF.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.CSF.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.CSF.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1.CSF.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.CSF.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.CSF.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.CSF.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.CSF.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.CSF.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.CSF.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1.CSF.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.CSF.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.CSF.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.CSF.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1.CSF.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.CSF.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.CSF.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.CSF.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.CSF.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.CSF.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.CSF.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1.CSF.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.CSF.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.CSF.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.CSF.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1.CSF.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.CSF.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.CSF.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.CSF.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.CSF.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.CSF.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.CSF.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1.CSF.intensity(t) = img_T1(indices(t));

end

%
% EDEMA
%

indices = find(mask == 115); %CSF

len = size(indices,1); %total de pixeis da mascara

struct.T1.EDEMA.ASM = zeros(len,4);
struct.T1.EDEMA.contrast = zeros(len,4);
struct.T1.EDEMA.correlation = zeros(len,4);
struct.T1.EDEMA.variance = zeros(len,4);
struct.T1.EDEMA.IDM = zeros(len,4);
struct.T1.EDEMA.sum_average = zeros(len,4);
struct.T1.EDEMA.sum_variance = zeros(len,4);
struct.T1.EDEMA.sum_entropy = zeros(len,4);
struct.T1.EDEMA.entropy = zeros(len,4);
struct.T1.EDEMA.diff_variance = zeros(len,4);
struct.T1.EDEMA.diff_entropy = zeros(len,4);
struct.T1.EDEMA.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1.EDEMA.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.EDEMA.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.EDEMA.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.EDEMA.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1.EDEMA.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.EDEMA.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.EDEMA.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.EDEMA.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.EDEMA.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.EDEMA.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.EDEMA.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1.EDEMA.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.EDEMA.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.EDEMA.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.EDEMA.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1.EDEMA.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.EDEMA.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.EDEMA.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.EDEMA.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.EDEMA.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.EDEMA.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.EDEMA.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1.EDEMA.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.EDEMA.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.EDEMA.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.EDEMA.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1.EDEMA.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.EDEMA.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.EDEMA.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.EDEMA.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.EDEMA.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.EDEMA.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.EDEMA.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1.EDEMA.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1.EDEMA.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1.EDEMA.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1.EDEMA.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1.EDEMA.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1.EDEMA.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1.EDEMA.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1.EDEMA.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1.EDEMA.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1.EDEMA.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1.EDEMA.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1.EDEMA.intensity(t) = img_T1(indices(t));

end



%----------------------%
%         T1C          %
%----------------------%

%
% MASSA BRANCA
%
indices = find(mask == 204); %WM

len = size(indices,1); %total de pixeis da mascara

struct.T1c.WM.ASM = zeros(len,4);
struct.T1c.WM.contrast = zeros(len,4);
struct.T1c.WM.correlation = zeros(len,4);
struct.T1c.WM.variance = zeros(len,4);
struct.T1c.WM.IDM = zeros(len,4);
struct.T1c.WM.sum_average = zeros(len,4);
struct.T1c.WM.sum_variance = zeros(len,4);
struct.T1c.WM.sum_entropy = zeros(len,4);
struct.T1c.WM.entropy = zeros(len,4);
struct.T1c.WM.diff_variance = zeros(len,4);
struct.T1c.WM.diff_entropy = zeros(len,4);
struct.T1c.WM.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1c,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1c.WM.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.WM.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.WM.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.WM.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.WM.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.WM.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.WM.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.WM.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.WM.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.WM.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.WM.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1c.WM.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.WM.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.WM.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.WM.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.WM.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.WM.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.WM.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.WM.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.WM.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.WM.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.WM.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1c.WM.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.WM.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.WM.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.WM.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.WM.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.WM.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.WM.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.WM.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.WM.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.WM.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.WM.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1c.WM.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.WM.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.WM.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.WM.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.WM.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.WM.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.WM.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.WM.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.WM.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.WM.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.WM.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1c.WM.intensity(t) = img_T1c(indices(t));

end

%
% MASSA CINZENTA
%
indices = find(mask == 153); %GM

len = size(indices,1); %total de pixeis da mascara

struct.T1c.GM.ASM = zeros(len,4);
struct.T1c.GM.contrast = zeros(len,4);
struct.T1c.GM.correlation = zeros(len,4);
struct.T1c.GM.variance = zeros(len,4);
struct.T1c.GM.IDM = zeros(len,4);
struct.T1c.GM.sum_average = zeros(len,4);
struct.T1c.GM.sum_variance = zeros(len,4);
struct.T1c.GM.sum_entropy = zeros(len,4);
struct.T1c.GM.entropy = zeros(len,4);
struct.T1c.GM.diff_variance = zeros(len,4);
struct.T1c.GM.diff_entropy = zeros(len,4);
struct.T1c.GM.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1c,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    structc.T1c.GM.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    structc.T1c.GM.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    structc.T1c.GM.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    structc.T1c.GM.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    structc.T1c.GM.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    structc.T1c.GM.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    structc.T1c.GM.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    structc.T1c.GM.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    structc.T1c.GM.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    structc.T1c.GM.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    structc.T1c.GM.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1c.GM.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.GM.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.GM.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.GM.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.GM.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.GM.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.GM.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.GM.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.GM.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.GM.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.GM.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1c.GM.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.GM.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.GM.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.GM.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.GM.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.GM.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.GM.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.GM.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.GM.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.GM.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.GM.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1c.GM.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.GM.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.GM.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.GM.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.GM.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.GM.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.GM.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.GM.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.GM.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.GM.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.GM.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1c.GM.intensity(t) = img_T1c(indices(t));

end


%
% LIQUOR
%
indices = find(mask == 76); %CSF

len = size(indices,1); %total de pixeis da mascara

struct.T1c.CSF.ASM = zeros(len,4);
struct.T1c.CSF.contrast = zeros(len,4);
struct.T1c.CSF.correlation = zeros(len,4);
struct.T1c.CSF.variance = zeros(len,4);
struct.T1c.CSF.IDM = zeros(len,4);
struct.T1c.CSF.sum_average = zeros(len,4);
struct.T1c.CSF.sum_variance = zeros(len,4);
struct.T1c.CSF.sum_entropy = zeros(len,4);
struct.T1c.CSF.entropy = zeros(len,4);
struct.T1c.CSF.diff_variance = zeros(len,4);
struct.T1c.CSF.diff_entropy = zeros(len,4);
struct.T1c.CSF.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1c,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1c.CSF.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.CSF.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.CSF.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.CSF.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.CSF.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.CSF.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.CSF.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.CSF.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.CSF.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.CSF.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.CSF.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1c.CSF.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.CSF.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.CSF.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.CSF.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.CSF.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.CSF.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.CSF.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.CSF.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.CSF.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.CSF.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.CSF.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1c.CSF.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.CSF.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.CSF.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.CSF.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.CSF.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.CSF.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.CSF.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.CSF.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.CSF.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.CSF.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.CSF.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1c.CSF.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.CSF.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.CSF.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.CSF.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.CSF.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.CSF.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.CSF.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.CSF.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.CSF.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.CSF.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.CSF.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1c.CSF.intensity(t) = img_T1c(indices(t));

end

%
% EDEMA
%

indices = find(mask == 115); %edema

len = size(indices,1); %total de pixeis da mascara

struct.T1c.EDEMA.ASM = zeros(len,4);
struct.T1c.EDEMA.contrast = zeros(len,4);
struct.T1c.EDEMA.correlation = zeros(len,4);
struct.T1c.EDEMA.variance = zeros(len,4);
struct.T1c.EDEMA.IDM = zeros(len,4);
struct.T1c.EDEMA.sum_average = zeros(len,4);
struct.T1c.EDEMA.sum_variance = zeros(len,4);
struct.T1c.EDEMA.sum_entropy = zeros(len,4);
struct.T1c.EDEMA.entropy = zeros(len,4);
struct.T1c.EDEMA.diff_variance = zeros(len,4);
struct.T1c.EDEMA.diff_entropy = zeros(len,4);
struct.T1c.EDEMA.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_T1c,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.T1c.EDEMA.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.EDEMA.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.EDEMA.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.EDEMA.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.EDEMA.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.EDEMA.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.EDEMA.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.EDEMA.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.EDEMA.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.EDEMA.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.EDEMA.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.T1c.EDEMA.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.EDEMA.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.EDEMA.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.EDEMA.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.EDEMA.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.EDEMA.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.EDEMA.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.EDEMA.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.EDEMA.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.EDEMA.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.EDEMA.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.T1c.EDEMA.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.EDEMA.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.EDEMA.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.EDEMA.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.EDEMA.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.EDEMA.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.EDEMA.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.EDEMA.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.EDEMA.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.EDEMA.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.EDEMA.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.T1c.EDEMA.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.T1c.EDEMA.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.T1c.EDEMA.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.T1c.EDEMA.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.T1c.EDEMA.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.T1c.EDEMA.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.T1c.EDEMA.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.T1c.EDEMA.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.T1c.EDEMA.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.T1c.EDEMA.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.T1c.EDEMA.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.T1c.EDEMA.intensity(t) = img_T1c(indices(t));

end




%----------------------%
%        FLAIR         %
%----------------------%

%
% MASSA BRANCA
%
indices = find(mask == 204); %WM

len = size(indices,1); %total de pixeis da mascara

struct.FLAIR.WM.ASM = zeros(len,4);
struct.FLAIR.WM.contrast = zeros(len,4);
struct.FLAIR.WM.correlation = zeros(len,4);
struct.FLAIR.WM.variance = zeros(len,4);
struct.FLAIR.WM.IDM = zeros(len,4);
struct.FLAIR.WM.sum_average = zeros(len,4);
struct.FLAIR.WM.sum_variance = zeros(len,4);
struct.FLAIR.WM.sum_entropy = zeros(len,4);
struct.FLAIR.WM.entropy = zeros(len,4);
struct.FLAIR.WM.diff_variance = zeros(len,4);
struct.FLAIR.WM.diff_entropy = zeros(len,4);
struct.FLAIR.WM.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_FLAIR,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.FLAIR.WM.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.WM.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.WM.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.WM.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.WM.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.WM.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.WM.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.WM.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.WM.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.WM.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.WM.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.FLAIR.WM.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.WM.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.WM.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.WM.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.WM.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.WM.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.WM.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.WM.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.WM.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.WM.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.WM.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.FLAIR.WM.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.WM.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.WM.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.WM.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.WM.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.WM.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.WM.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.WM.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.WM.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.WM.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.WM.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.FLAIR.WM.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.WM.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.WM.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.WM.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.WM.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.WM.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.WM.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.WM.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.WM.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.WM.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.WM.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.FLAIR.WM.intensity(t) = img_FLAIR(indices(t));

end

%
% MASSA CINZENTA
%
indices = find(mask == 153); %GM

len = size(indices,1); %total de pixeis da mascara

struct.FLAIR.GM.ASM = zeros(len,4);
struct.FLAIR.GM.contrast = zeros(len,4);
struct.FLAIR.GM.correlation = zeros(len,4);
struct.FLAIR.GM.variance = zeros(len,4);
struct.FLAIR.GM.IDM = zeros(len,4);
struct.FLAIR.GM.sum_average = zeros(len,4);
struct.FLAIR.GM.sum_variance = zeros(len,4);
struct.FLAIR.GM.sum_entropy = zeros(len,4);
struct.FLAIR.GM.entropy = zeros(len,4);
struct.FLAIR.GM.diff_variance = zeros(len,4);
struct.FLAIR.GM.diff_entropy = zeros(len,4);
struct.FLAIR.GM.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_FLAIR,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    structc.FLAIR.GM.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    structc.FLAIR.GM.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    structc.FLAIR.GM.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    structc.FLAIR.GM.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    structc.FLAIR.GM.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    structc.FLAIR.GM.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    structc.FLAIR.GM.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    structc.FLAIR.GM.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    structc.FLAIR.GM.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    structc.FLAIR.GM.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    structc.FLAIR.GM.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.FLAIR.GM.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.GM.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.GM.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.GM.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.GM.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.GM.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.GM.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.GM.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.GM.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.GM.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.GM.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.FLAIR.GM.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.GM.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.GM.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.GM.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.GM.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.GM.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.GM.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.GM.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.GM.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.GM.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.GM.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.FLAIR.GM.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.GM.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.GM.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.GM.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.GM.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.GM.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.GM.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.GM.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.GM.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.GM.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.GM.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.FLAIR.GM.intensity(t) = img_FLAIR(indices(t));

end


%
% LIQUOR
%
indices = find(mask == 76); %CSF

len = size(indices,1); %total de pixeis da mascara

struct.FLAIR.CSF.ASM = zeros(len,4);
struct.FLAIR.CSF.contrast = zeros(len,4);
struct.FLAIR.CSF.correlation = zeros(len,4);
struct.FLAIR.CSF.variance = zeros(len,4);
struct.FLAIR.CSF.IDM = zeros(len,4);
struct.FLAIR.CSF.sum_average = zeros(len,4);
struct.FLAIR.CSF.sum_variance = zeros(len,4);
struct.FLAIR.CSF.sum_entropy = zeros(len,4);
struct.FLAIR.CSF.entropy = zeros(len,4);
struct.FLAIR.CSF.diff_variance = zeros(len,4);
struct.FLAIR.CSF.diff_entropy = zeros(len,4);
struct.FLAIR.CSF.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_FLAIR,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.FLAIR.CSF.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.CSF.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.CSF.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.CSF.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.CSF.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.CSF.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.CSF.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.CSF.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.CSF.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.CSF.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.CSF.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.FLAIR.CSF.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.CSF.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.CSF.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.CSF.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.CSF.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.CSF.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.CSF.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.CSF.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.CSF.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.CSF.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.CSF.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.FLAIR.CSF.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.CSF.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.CSF.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.CSF.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.CSF.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.CSF.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.CSF.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.CSF.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.CSF.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.CSF.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.CSF.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.FLAIR.CSF.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.CSF.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.CSF.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.CSF.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.CSF.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.CSF.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.CSF.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.CSF.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.CSF.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.CSF.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.CSF.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.FLAIR.CSF.intensity(t) = img_FLAIR(indices(t));

end

%
% EDEMA
%

indices = find(mask == 115); %edema

len = size(indices,1); %total de pixeis da mascara

struct.FLAIR.EDEMA.ASM = zeros(len,4);
struct.FLAIR.EDEMA.contrast = zeros(len,4);
struct.FLAIR.EDEMA.correlation = zeros(len,4);
struct.FLAIR.EDEMA.variance = zeros(len,4);
struct.FLAIR.EDEMA.IDM = zeros(len,4);
struct.FLAIR.EDEMA.sum_average = zeros(len,4);
struct.FLAIR.EDEMA.sum_variance = zeros(len,4);
struct.FLAIR.EDEMA.sum_entropy = zeros(len,4);
struct.FLAIR.EDEMA.entropy = zeros(len,4);
struct.FLAIR.EDEMA.diff_variance = zeros(len,4);
struct.FLAIR.EDEMA.diff_entropy = zeros(len,4);
struct.FLAIR.EDEMA.intensity = zeros(len,1);


%pega caracteristicas
for t = 1:len
    w = getwindow(indices(t),img_FLAIR,janela);
    
    % 0 graus
    ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,0,1);
    
    struct.FLAIR.EDEMA.ASM(t,1) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.EDEMA.contrast(t,1) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.EDEMA.correlation(t,1) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.EDEMA.variance(t,1) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.EDEMA.IDM(t,1) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.EDEMA.sum_average(t,1) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.EDEMA.sum_variance(t,1) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.EDEMA.sum_entropy(t,1) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.EDEMA.entropy(t,1) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.EDEMA.diff_variance(t,1) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.EDEMA.diff_entropy(t,1) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 90 graus
    ccm = graycomatrix(w,'Offset',[-1 0],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,2,1);
    
    struct.FLAIR.EDEMA.ASM(t,2) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.EDEMA.contrast(t,2) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.EDEMA.correlation(t,2) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.EDEMA.variance(t,2) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.EDEMA.IDM(t,2) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.EDEMA.sum_average(t,2) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.EDEMA.sum_variance(t,2) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.EDEMA.sum_entropy(t,2) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.EDEMA.entropy(t,2) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.EDEMA.diff_variance(t,2) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.EDEMA.diff_entropy(t,2) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 45 graus
    ccm = graycomatrix(w,'Offset',[-1 1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,1,1);
    
    struct.FLAIR.EDEMA.ASM(t,3) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.EDEMA.contrast(t,3) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.EDEMA.correlation(t,3) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.EDEMA.variance(t,3) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.EDEMA.IDM(t,3) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.EDEMA.sum_average(t,3) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.EDEMA.sum_variance(t,3) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.EDEMA.sum_entropy(t,3) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.EDEMA.entropy(t,3) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.EDEMA.diff_variance(t,3) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.EDEMA.diff_entropy(t,3) = grayccmfeatures(ccm_n,'diff_entropy');
    
    % 135 graus
    ccm = graycomatrix(w,'Offset',[-1 -1],'NumLevels',16,'Symmetric',true);    
    ccm_n = normalize_ccm(ccm,3,1);  
    
    struct.FLAIR.EDEMA.ASM(t,4) = grayccmfeatures(ccm_n,'ASM');
    struct.FLAIR.EDEMA.contrast(t,4) = grayccmfeatures(ccm_n,'contrast');
    struct.FLAIR.EDEMA.correlation(t,4) = grayccmfeatures(ccm_n,'correlation');
    struct.FLAIR.EDEMA.variance(t,4) = grayccmfeatures(ccm_n,'variance');
    struct.FLAIR.EDEMA.IDM(t,4) = grayccmfeatures(ccm_n,'IDM');
    struct.FLAIR.EDEMA.sum_average(t,4) = grayccmfeatures(ccm_n,'sum_average');
    struct.FLAIR.EDEMA.sum_variance(t,4) = grayccmfeatures(ccm_n,'sum_variance');
    struct.FLAIR.EDEMA.sum_entropy(t,4) = grayccmfeatures(ccm_n,'sum_entropy');
    struct.FLAIR.EDEMA.entropy(t,4) = grayccmfeatures(ccm_n,'entropy');
    struct.FLAIR.EDEMA.diff_variance(t,4) = grayccmfeatures(ccm_n,'diff_variance');
    struct.FLAIR.EDEMA.diff_entropy(t,4) = grayccmfeatures(ccm_n,'diff_entropy');
    
    struct.FLAIR.EDEMA.intensity(t) = img_FLAIR(indices(t));

end

