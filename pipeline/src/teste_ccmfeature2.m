function teste_ccmfeature2(model_wm, model_gm, model_csf, model_edema)


%mask = imread('vicenzo_T1_mask_2class.bmp');

mask = imread('aurora_T1_mask_2class.bmp');

indices = find(mask ~= 255);

len = size(indices,1); %total de pixeis da mascara


data = load('aurora_data_geral.mat');
%data = load('vicenzo_data_geral.mat');


ASM_T1 = data.struct.T1.ASM;
contrast_T1 = data.struct.T1.contrast;
correlation_T1 = data.struct.T1.correlation;
variance_T1 = data.struct.T1.variance;
IDM_T1 = data.struct.T1.IDM;
sum_average_T1 = data.struct.T1.sum_average;
sum_variance_T1 = data.struct.T1.sum_variance;
sum_entropy_T1 = data.struct.T1.sum_entropy;
entropy_T1 = data.struct.T1.entropy;
diff_variance_T1 = data.struct.T1.diff_variance;
diff_entropy_T1 = data.struct.T1.diff_entropy;
intensity_T1 = data.struct.T1.intensity;

ASM_T1c = data.struct.T1c.ASM;
contrast_T1c = data.struct.T1c.contrast;
correlation_T1c = data.struct.T1c.correlation;
variance_T1c = data.struct.T1c.variance;
IDM_T1c = data.struct.T1c.IDM;
sum_average_T1c = data.struct.T1c.sum_average;
sum_variance_T1c = data.struct.T1c.sum_variance;
sum_entropy_T1c = data.struct.T1c.sum_entropy;
entropy_T1c = data.struct.T1c.entropy;
diff_variance_T1c = data.struct.T1c.diff_variance;
diff_entropy_T1c = data.struct.T1c.diff_entropy;
intensity_T1c = data.struct.T1c.intensity;

ASM_FLAIR = data.struct.FLAIR.ASM;
contrast_FLAIR = data.struct.FLAIR.contrast;
correlation_FLAIR = data.struct.FLAIR.correlation;
variance_FLAIR = data.struct.FLAIR.variance;
IDM_FLAIR = data.struct.FLAIR.IDM;
sum_average_FLAIR = data.struct.FLAIR.sum_average;
sum_variance_FLAIR = data.struct.FLAIR.sum_variance;
sum_entropy_FLAIR = data.struct.FLAIR.sum_entropy;
entropy_FLAIR = data.struct.FLAIR.entropy;
diff_variance_FLAIR = data.struct.FLAIR.diff_variance;
diff_entropy_FLAIR = data.struct.FLAIR.diff_entropy;
intensity_FLAIR = data.struct.FLAIR.intensity;

teste = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1 intensity_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c intensity_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR intensity_FLAIR];
%teste = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR];

teste = rescale(teste,0,1);
labels = zeros(len,1);

saida = zeros(size(mask));


[classificacao, precisao, probabilidades] = svmpredict(labels, teste, model_wm); %classifica WM
saida(indices(classificacao == 1)) = 200;

[classificacao, precisao, probabilidades] = svmpredict(labels, teste, model_gm); %classifica GM
saida(indices(classificacao == 1)) = 150;

[classificacao, precisao, probabilidades] = svmpredict(labels, teste, model_csf); %classifica CSF
saida(indices(classificacao == 1)) = 100;

[classificacao, precisao, probabilidades] = svmpredict(labels, teste, model_edema); %classifica edema
saida(indices(classificacao == 1)) = 50;

imwrite(gscale(saida),'saida_3canais.bmp','BMP');