function [model_wm model_gm model_csf model_edema] = treina_SVMs2()

data = load('vicenzo_data.mat');
data2 = load('aurora_data.mat');



% massa branca

len = size(data.struct.T1.WM.ASM,1);

labels = ones(len,1);

ASM_T1 = data.struct.T1.WM.ASM;
contrast_T1 = data.struct.T1.WM.contrast;
correlation_T1 = data.struct.T1.WM.correlation;
variance_T1 = data.struct.T1.WM.variance;
IDM_T1 = data.struct.T1.WM.IDM;
sum_average_T1 = data.struct.T1.WM.sum_average;
sum_variance_T1 = data.struct.T1.WM.sum_variance;
sum_entropy_T1 = data.struct.T1.WM.sum_entropy;
entropy_T1 = data.struct.T1.WM.entropy;
diff_variance_T1 = data.struct.T1.WM.diff_variance;
diff_entropy_T1 = data.struct.T1.WM.diff_entropy;
intensity_T1 = data.struct.T1.WM.intensity;

ASM_T1c = data.struct.T1c.WM.ASM;
contrast_T1c = data.struct.T1c.WM.contrast;
correlation_T1c = data.struct.T1c.WM.correlation;
variance_T1c = data.struct.T1c.WM.variance;
IDM_T1c = data.struct.T1c.WM.IDM;
sum_average_T1c = data.struct.T1c.WM.sum_average;
sum_variance_T1c = data.struct.T1c.WM.sum_variance;
sum_entropy_T1c = data.struct.T1c.WM.sum_entropy;
entropy_T1c = data.struct.T1c.WM.entropy;
diff_variance_T1c = data.struct.T1c.WM.diff_variance;
diff_entropy_T1c = data.struct.T1c.WM.diff_entropy;
intensity_T1c = data.struct.T1c.WM.intensity;

ASM_FLAIR = data.struct.FLAIR.WM.ASM;
contrast_FLAIR = data.struct.FLAIR.WM.contrast;
correlation_FLAIR = data.struct.FLAIR.WM.correlation;
variance_FLAIR = data.struct.FLAIR.WM.variance;
IDM_FLAIR = data.struct.FLAIR.WM.IDM;
sum_average_FLAIR = data.struct.FLAIR.WM.sum_average;
sum_variance_FLAIR = data.struct.FLAIR.WM.sum_variance;
sum_entropy_FLAIR = data.struct.FLAIR.WM.sum_entropy;
entropy_FLAIR = data.struct.FLAIR.WM.entropy;
diff_variance_FLAIR = data.struct.FLAIR.WM.diff_variance;
diff_entropy_FLAIR = data.struct.FLAIR.WM.diff_entropy;
intensity_FLAIR = data.struct.FLAIR.WM.intensity;

features = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1 intensity_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c intensity_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR intensity_FLAIR];
%features = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR];

ASM_T1 = data2.struct.T1.WM.ASM;
contrast_T1 = data2.struct.T1.WM.contrast;
correlation_T1 = data2.struct.T1.WM.correlation;
variance_T1 = data2.struct.T1.WM.variance;
IDM_T1 = data2.struct.T1.WM.IDM;
sum_average_T1 = data2.struct.T1.WM.sum_average;
sum_variance_T1 = data2.struct.T1.WM.sum_variance;
sum_entropy_T1 = data2.struct.T1.WM.sum_entropy;
entropy_T1 = data2.struct.T1.WM.entropy;
diff_variance_T1 = data2.struct.T1.WM.diff_variance;
diff_entropy_T1 = data2.struct.T1.WM.diff_entropy;
intensity_T1 = data2.struct.T1.WM.intensity;

ASM_T1c = data2.struct.T1c.WM.ASM;
contrast_T1c = data2.struct.T1c.WM.contrast;
correlation_T1c = data2.struct.T1c.WM.correlation;
variance_T1c = data2.struct.T1c.WM.variance;
IDM_T1c = data2.struct.T1c.WM.IDM;
sum_average_T1c = data2.struct.T1c.WM.sum_average;
sum_variance_T1c = data2.struct.T1c.WM.sum_variance;
sum_entropy_T1c = data2.struct.T1c.WM.sum_entropy;
entropy_T1c = data2.struct.T1c.WM.entropy;
diff_variance_T1c = data2.struct.T1c.WM.diff_variance;
diff_entropy_T1c = data2.struct.T1c.WM.diff_entropy;
intensity_T1c = data2.struct.T1c.WM.intensity;

ASM_FLAIR = data2.struct.FLAIR.WM.ASM;
contrast_FLAIR = data2.struct.FLAIR.WM.contrast;
correlation_FLAIR = data2.struct.FLAIR.WM.correlation;
variance_FLAIR = data2.struct.FLAIR.WM.variance;
IDM_FLAIR = data2.struct.FLAIR.WM.IDM;
sum_average_FLAIR = data2.struct.FLAIR.WM.sum_average;
sum_variance_FLAIR = data2.struct.FLAIR.WM.sum_variance;
sum_entropy_FLAIR = data2.struct.FLAIR.WM.sum_entropy;
entropy_FLAIR = data2.struct.FLAIR.WM.entropy;
diff_variance_FLAIR = data2.struct.FLAIR.WM.diff_variance;
diff_entropy_FLAIR = data2.struct.FLAIR.WM.diff_entropy;
intensity_FLAIR = data2.struct.FLAIR.WM.intensity;

features2 = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1 intensity_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c intensity_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR intensity_FLAIR];
%features2 = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR];

features = [features; features2];

features = rescale(features,0,1);

model_wm = svmtrain(labels,features,'-s 2 -t 2 -n 0.4'); %treina



% massa cinzenta

len = size(data.struct.T1.GM.ASM,1);

labels = ones(len,1);

ASM_T1 = data.struct.T1.GM.ASM;
contrast_T1 = data.struct.T1.GM.contrast;
correlation_T1 = data.struct.T1.GM.correlation;
variance_T1 = data.struct.T1.GM.variance;
IDM_T1 = data.struct.T1.GM.IDM;
sum_average_T1 = data.struct.T1.GM.sum_average;
sum_variance_T1 = data.struct.T1.GM.sum_variance;
sum_entropy_T1 = data.struct.T1.GM.sum_entropy;
entropy_T1 = data.struct.T1.GM.entropy;
diff_variance_T1 = data.struct.T1.GM.diff_variance;
diff_entropy_T1 = data.struct.T1.GM.diff_entropy;
intensity_T1 = data.struct.T1.GM.intensity;

ASM_T1c = data.struct.T1c.GM.ASM;
contrast_T1c = data.struct.T1c.GM.contrast;
correlation_T1c = data.struct.T1c.GM.correlation;
variance_T1c = data.struct.T1c.GM.variance;
IDM_T1c = data.struct.T1c.GM.IDM;
sum_average_T1c = data.struct.T1c.GM.sum_average;
sum_variance_T1c = data.struct.T1c.GM.sum_variance;
sum_entropy_T1c = data.struct.T1c.GM.sum_entropy;
entropy_T1c = data.struct.T1c.GM.entropy;
diff_variance_T1c = data.struct.T1c.GM.diff_variance;
diff_entropy_T1c = data.struct.T1c.GM.diff_entropy;
intensity_T1c = data.struct.T1c.GM.intensity;

ASM_FLAIR = data.struct.FLAIR.GM.ASM;
contrast_FLAIR = data.struct.FLAIR.GM.contrast;
correlation_FLAIR = data.struct.FLAIR.GM.correlation;
variance_FLAIR = data.struct.FLAIR.GM.variance;
IDM_FLAIR = data.struct.FLAIR.GM.IDM;
sum_average_FLAIR = data.struct.FLAIR.GM.sum_average;
sum_variance_FLAIR = data.struct.FLAIR.GM.sum_variance;
sum_entropy_FLAIR = data.struct.FLAIR.GM.sum_entropy;
entropy_FLAIR = data.struct.FLAIR.GM.entropy;
diff_variance_FLAIR = data.struct.FLAIR.GM.diff_variance;
diff_entropy_FLAIR = data.struct.FLAIR.GM.diff_entropy;
intensity_FLAIR = data.struct.FLAIR.GM.intensity;

features = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1 intensity_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c intensity_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR intensity_FLAIR];
%features = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR];

ASM_T1 = data2.struct.T1.GM.ASM;
contrast_T1 = data2.struct.T1.GM.contrast;
correlation_T1 = data2.struct.T1.GM.correlation;
variance_T1 = data2.struct.T1.GM.variance;
IDM_T1 = data2.struct.T1.GM.IDM;
sum_average_T1 = data2.struct.T1.GM.sum_average;
sum_variance_T1 = data2.struct.T1.GM.sum_variance;
sum_entropy_T1 = data2.struct.T1.GM.sum_entropy;
entropy_T1 = data2.struct.T1.GM.entropy;
diff_variance_T1 = data2.struct.T1.GM.diff_variance;
diff_entropy_T1 = data2.struct.T1.GM.diff_entropy;
intensity_T1 = data2.struct.T1.GM.intensity;

ASM_T1c = data2.struct.T1c.GM.ASM;
contrast_T1c = data2.struct.T1c.GM.contrast;
correlation_T1c = data2.struct.T1c.GM.correlation;
variance_T1c = data2.struct.T1c.GM.variance;
IDM_T1c = data2.struct.T1c.GM.IDM;
sum_average_T1c = data2.struct.T1c.GM.sum_average;
sum_variance_T1c = data2.struct.T1c.GM.sum_variance;
sum_entropy_T1c = data2.struct.T1c.GM.sum_entropy;
entropy_T1c = data2.struct.T1c.GM.entropy;
diff_variance_T1c = data2.struct.T1c.GM.diff_variance;
diff_entropy_T1c = data2.struct.T1c.GM.diff_entropy;
intensity_T1c = data2.struct.T1c.GM.intensity;

ASM_FLAIR = data2.struct.FLAIR.GM.ASM;
contrast_FLAIR = data2.struct.FLAIR.GM.contrast;
correlation_FLAIR = data2.struct.FLAIR.GM.correlation;
variance_FLAIR = data2.struct.FLAIR.GM.variance;
IDM_FLAIR = data2.struct.FLAIR.GM.IDM;
sum_average_FLAIR = data2.struct.FLAIR.GM.sum_average;
sum_variance_FLAIR = data2.struct.FLAIR.GM.sum_variance;
sum_entropy_FLAIR = data2.struct.FLAIR.GM.sum_entropy;
entropy_FLAIR = data2.struct.FLAIR.GM.entropy;
diff_variance_FLAIR = data2.struct.FLAIR.GM.diff_variance;
diff_entropy_FLAIR = data2.struct.FLAIR.GM.diff_entropy;
intensity_FLAIR = data2.struct.FLAIR.GM.intensity;

features2 = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1 intensity_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c intensity_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR intensity_FLAIR];
%features2 = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR];

features = [features; features2];

features = rescale(features,0,1);

model_gm = svmtrain(labels,features,'-s 2 -t 2 -n 0.4'); %treina



% liquor

len = size(data.struct.T1.CSF.ASM,1);

labels = ones(len,1);

ASM_T1 = data.struct.T1.CSF.ASM;
contrast_T1 = data.struct.T1.CSF.contrast;
correlation_T1 = data.struct.T1.CSF.correlation;
variance_T1 = data.struct.T1.CSF.variance;
IDM_T1 = data.struct.T1.CSF.IDM;
sum_average_T1 = data.struct.T1.CSF.sum_average;
sum_variance_T1 = data.struct.T1.CSF.sum_variance;
sum_entropy_T1 = data.struct.T1.CSF.sum_entropy;
entropy_T1 = data.struct.T1.CSF.entropy;
diff_variance_T1 = data.struct.T1.CSF.diff_variance;
diff_entropy_T1 = data.struct.T1.CSF.diff_entropy;
intensity_T1 = data.struct.T1.CSF.intensity;

ASM_T1c = data.struct.T1c.CSF.ASM;
contrast_T1c = data.struct.T1c.CSF.contrast;
correlation_T1c = data.struct.T1c.CSF.correlation;
variance_T1c = data.struct.T1c.CSF.variance;
IDM_T1c = data.struct.T1c.CSF.IDM;
sum_average_T1c = data.struct.T1c.CSF.sum_average;
sum_variance_T1c = data.struct.T1c.CSF.sum_variance;
sum_entropy_T1c = data.struct.T1c.CSF.sum_entropy;
entropy_T1c = data.struct.T1c.CSF.entropy;
diff_variance_T1c = data.struct.T1c.CSF.diff_variance;
diff_entropy_T1c = data.struct.T1c.CSF.diff_entropy;
intensity_T1c = data.struct.T1c.CSF.intensity;

ASM_FLAIR = data.struct.FLAIR.CSF.ASM;
contrast_FLAIR = data.struct.FLAIR.CSF.contrast;
correlation_FLAIR = data.struct.FLAIR.CSF.correlation;
variance_FLAIR = data.struct.FLAIR.CSF.variance;
IDM_FLAIR = data.struct.FLAIR.CSF.IDM;
sum_average_FLAIR = data.struct.FLAIR.CSF.sum_average;
sum_variance_FLAIR = data.struct.FLAIR.CSF.sum_variance;
sum_entropy_FLAIR = data.struct.FLAIR.CSF.sum_entropy;
entropy_FLAIR = data.struct.FLAIR.CSF.entropy;
diff_variance_FLAIR = data.struct.FLAIR.CSF.diff_variance;
diff_entropy_FLAIR = data.struct.FLAIR.CSF.diff_entropy;
intensity_FLAIR = data.struct.FLAIR.CSF.intensity;

features = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1 intensity_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c intensity_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR intensity_FLAIR];
%features = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR];


ASM_T1 = data2.struct.T1.CSF.ASM;
contrast_T1 = data2.struct.T1.CSF.contrast;
correlation_T1 = data2.struct.T1.CSF.correlation;
variance_T1 = data2.struct.T1.CSF.variance;
IDM_T1 = data2.struct.T1.CSF.IDM;
sum_average_T1 = data2.struct.T1.CSF.sum_average;
sum_variance_T1 = data2.struct.T1.CSF.sum_variance;
sum_entropy_T1 = data2.struct.T1.CSF.sum_entropy;
entropy_T1 = data2.struct.T1.CSF.entropy;
diff_variance_T1 = data2.struct.T1.CSF.diff_variance;
diff_entropy_T1 = data2.struct.T1.CSF.diff_entropy;
intensity_T1 = data2.struct.T1.CSF.intensity;

ASM_T1c = data2.struct.T1c.CSF.ASM;
contrast_T1c = data2.struct.T1c.CSF.contrast;
correlation_T1c = data2.struct.T1c.CSF.correlation;
variance_T1c = data2.struct.T1c.CSF.variance;
IDM_T1c = data2.struct.T1c.CSF.IDM;
sum_average_T1c = data2.struct.T1c.CSF.sum_average;
sum_variance_T1c = data2.struct.T1c.CSF.sum_variance;
sum_entropy_T1c = data2.struct.T1c.CSF.sum_entropy;
entropy_T1c = data2.struct.T1c.CSF.entropy;
diff_variance_T1c = data2.struct.T1c.CSF.diff_variance;
diff_entropy_T1c = data2.struct.T1c.CSF.diff_entropy;
intensity_T1c = data2.struct.T1c.CSF.intensity;

ASM_FLAIR = data2.struct.FLAIR.CSF.ASM;
contrast_FLAIR = data2.struct.FLAIR.CSF.contrast;
correlation_FLAIR = data2.struct.FLAIR.CSF.correlation;
variance_FLAIR = data2.struct.FLAIR.CSF.variance;
IDM_FLAIR = data2.struct.FLAIR.CSF.IDM;
sum_average_FLAIR = data2.struct.FLAIR.CSF.sum_average;
sum_variance_FLAIR = data2.struct.FLAIR.CSF.sum_variance;
sum_entropy_FLAIR = data2.struct.FLAIR.CSF.sum_entropy;
entropy_FLAIR = data2.struct.FLAIR.CSF.entropy;
diff_variance_FLAIR = data2.struct.FLAIR.CSF.diff_variance;
diff_entropy_FLAIR = data2.struct.FLAIR.CSF.diff_entropy;
intensity_FLAIR = data2.struct.FLAIR.CSF.intensity;

features2 = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1 intensity_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c intensity_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR intensity_FLAIR];
%features2 = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR];

features = [features; features2];


features = rescale(features,0,1);

model_csf = svmtrain(labels,features,'-s 2 -t 2 -n 0.4'); %treina



% edema

len = size(data.struct.T1.EDEMA.ASM,1);

labels = ones(len,1);

ASM_T1 = data.struct.T1.EDEMA.ASM;
contrast_T1 = data.struct.T1.EDEMA.contrast;
correlation_T1 = data.struct.T1.EDEMA.correlation;
variance_T1 = data.struct.T1.EDEMA.variance;
IDM_T1 = data.struct.T1.EDEMA.IDM;
sum_average_T1 = data.struct.T1.EDEMA.sum_average;
sum_variance_T1 = data.struct.T1.EDEMA.sum_variance;
sum_entropy_T1 = data.struct.T1.EDEMA.sum_entropy;
entropy_T1 = data.struct.T1.EDEMA.entropy;
diff_variance_T1 = data.struct.T1.EDEMA.diff_variance;
diff_entropy_T1 = data.struct.T1.EDEMA.diff_entropy;
intensity_T1 = data.struct.T1.EDEMA.intensity;

ASM_T1c = data.struct.T1c.EDEMA.ASM;
contrast_T1c = data.struct.T1c.EDEMA.contrast;
correlation_T1c = data.struct.T1c.EDEMA.correlation;
variance_T1c = data.struct.T1c.EDEMA.variance;
IDM_T1c = data.struct.T1c.EDEMA.IDM;
sum_average_T1c = data.struct.T1c.EDEMA.sum_average;
sum_variance_T1c = data.struct.T1c.EDEMA.sum_variance;
sum_entropy_T1c = data.struct.T1c.EDEMA.sum_entropy;
entropy_T1c = data.struct.T1c.EDEMA.entropy;
diff_variance_T1c = data.struct.T1c.EDEMA.diff_variance;
diff_entropy_T1c = data.struct.T1c.EDEMA.diff_entropy;
intensity_T1c = data.struct.T1c.EDEMA.intensity;

ASM_FLAIR = data.struct.FLAIR.EDEMA.ASM;
contrast_FLAIR = data.struct.FLAIR.EDEMA.contrast;
correlation_FLAIR = data.struct.FLAIR.EDEMA.correlation;
variance_FLAIR = data.struct.FLAIR.EDEMA.variance;
IDM_FLAIR = data.struct.FLAIR.EDEMA.IDM;
sum_average_FLAIR = data.struct.FLAIR.EDEMA.sum_average;
sum_variance_FLAIR = data.struct.FLAIR.EDEMA.sum_variance;
sum_entropy_FLAIR = data.struct.FLAIR.EDEMA.sum_entropy;
entropy_FLAIR = data.struct.FLAIR.EDEMA.entropy;
diff_variance_FLAIR = data.struct.FLAIR.EDEMA.diff_variance;
diff_entropy_FLAIR = data.struct.FLAIR.EDEMA.diff_entropy;
intensity_FLAIR = data.struct.FLAIR.EDEMA.intensity;

features = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1 intensity_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c intensity_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR intensity_FLAIR];
%features = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR];

ASM_T1 = data2.struct.T1.EDEMA.ASM;
contrast_T1 = data2.struct.T1.EDEMA.contrast;
correlation_T1 = data2.struct.T1.EDEMA.correlation;
variance_T1 = data2.struct.T1.EDEMA.variance;
IDM_T1 = data2.struct.T1.EDEMA.IDM;
sum_average_T1 = data2.struct.T1.EDEMA.sum_average;
sum_variance_T1 = data2.struct.T1.EDEMA.sum_variance;
sum_entropy_T1 = data2.struct.T1.EDEMA.sum_entropy;
entropy_T1 = data2.struct.T1.EDEMA.entropy;
diff_variance_T1 = data2.struct.T1.EDEMA.diff_variance;
diff_entropy_T1 = data2.struct.T1.EDEMA.diff_entropy;
intensity_T1 = data2.struct.T1.EDEMA.intensity;

ASM_T1c = data2.struct.T1c.EDEMA.ASM;
contrast_T1c = data2.struct.T1c.EDEMA.contrast;
correlation_T1c = data2.struct.T1c.EDEMA.correlation;
variance_T1c = data2.struct.T1c.EDEMA.variance;
IDM_T1c = data2.struct.T1c.EDEMA.IDM;
sum_average_T1c = data2.struct.T1c.EDEMA.sum_average;
sum_variance_T1c = data2.struct.T1c.EDEMA.sum_variance;
sum_entropy_T1c = data2.struct.T1c.EDEMA.sum_entropy;
entropy_T1c = data2.struct.T1c.EDEMA.entropy;
diff_variance_T1c = data2.struct.T1c.EDEMA.diff_variance;
diff_entropy_T1c = data2.struct.T1c.EDEMA.diff_entropy;
intensity_T1c = data2.struct.T1c.EDEMA.intensity;

ASM_FLAIR = data2.struct.FLAIR.EDEMA.ASM;
contrast_FLAIR = data2.struct.FLAIR.EDEMA.contrast;
correlation_FLAIR = data2.struct.FLAIR.EDEMA.correlation;
variance_FLAIR = data2.struct.FLAIR.EDEMA.variance;
IDM_FLAIR = data2.struct.FLAIR.EDEMA.IDM;
sum_average_FLAIR = data2.struct.FLAIR.EDEMA.sum_average;
sum_variance_FLAIR = data2.struct.FLAIR.EDEMA.sum_variance;
sum_entropy_FLAIR = data2.struct.FLAIR.EDEMA.sum_entropy;
entropy_FLAIR = data2.struct.FLAIR.EDEMA.entropy;
diff_variance_FLAIR = data2.struct.FLAIR.EDEMA.diff_variance;
diff_entropy_FLAIR = data2.struct.FLAIR.EDEMA.diff_entropy;
intensity_FLAIR = data2.struct.FLAIR.EDEMA.intensity;

features2 = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1 intensity_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c intensity_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR intensity_FLAIR];
%features2 = [ASM_T1 contrast_T1 correlation_T1 variance_T1 IDM_T1 sum_average_T1 sum_variance_T1 sum_entropy_T1 entropy_T1 diff_variance_T1 diff_entropy_T1  ASM_T1c contrast_T1c correlation_T1c variance_T1c IDM_T1c sum_average_T1c sum_variance_T1c sum_entropy_T1c entropy_T1c diff_variance_T1c diff_entropy_T1c  ASM_FLAIR contrast_FLAIR correlation_FLAIR variance_FLAIR IDM_FLAIR sum_average_FLAIR sum_variance_FLAIR sum_entropy_FLAIR entropy_FLAIR diff_variance_FLAIR diff_entropy_FLAIR];

features = [features; features2];

features = rescale(features,0,1);

model_edema = svmtrain(labels,features,'-s 2 -t 2 -n 0.4'); %treina