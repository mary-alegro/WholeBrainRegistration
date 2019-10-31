function posprocess_histo_color_3D(casedir,ref_mri)

% 
% Applies the 3D registration transform to the R G B channels in order to create a color
% volume.
%
% CASEDIR : root dir for the case. I.e. /storage/Brains/Case01
% REF_MRI: reference MRI volume name
%


if casedir(end) ~= '/'
    casedir = [casedir '/'];
end    

histo_dir = strcat(casedir,'histology/');
histo2mri_dir = strcat(histo_dir,'intnorm2/volume/');
final_dir = strcat(histo_dir,'final/');
color3d_dir = strcat(final_dir,'3d/');
tmp_color_dir = strcat(final_dir,'tmp/');
color2d_dir = strcat(final_dir,'2d/'); %2d registered color slices

ext = 'tif';
%ext = 'mgz';

% histo_dir = strcat(casedir,'histology/');
% final_dir = strcat(histo_dir,'final/');
% histo2mri_dir = strcat(histo_dir,'intnormreg/volume/');
% color2d_dir = strcat(final_dir,'2d/'); %2d registered color slices
% color3d_dir = strcat(final_dir,'3d/');
% %tmp_color_dir = strcat(final_dir,'tmp/');

R_prefix = 'intcorr_R_t_';
G_prefix = 'intcorr_G_t_';
B_prefix = 'intcorr_B_t_';

%
% Creates R,G and B 3D volumes
%

red_files = dir(strcat(color2d_dir,R_prefix,'*.',ext));
red_files = sortfiles(red_files);
green_files = dir(strcat(color2d_dir,G_prefix,'*.',ext));
green_files = sortfiles(green_files);
blue_files = dir(strcat(color2d_dir,B_prefix,'*.',ext));
blue_files = sortfiles(blue_files);

nFiles = length(red_files);

red_vol = [];
green_vol = [];
blue_vol = [];

%%%%%%%%%%%%

%load reference volume in order to retrieve the vox2ras0 matrix
histo2mri_file = strcat(histo2mri_dir,ref_mri);
histo2mri = MRIread(histo2mri_file);
vox2ras0 = histo2mri.vox2ras0; 
% 
% %create red volume
% for f=1:nFiles
%     R_file = strcat(color2d_dir,red_files(f).name);
%     R_img = imread(R_file);
%     red_vol = cat(3,red_vol,R_img);
% end
% R_vol_file = strcat(color3d_dir,'R_histo_volume.mgz');
% mgz.vol = red_vol;
% mgz.vox2ras0 = vox2ras0;
% MRIwrite(mgz,R_vol_file);
% 
% %to save memory
% clear red_vol;
% clear mgz;
% 
% for f=1:nFiles
%      G_file = strcat(color2d_dir,green_files(f).name);
%      G_img = imread(G_file);
%      
%      green_vol = cat(3,green_vol,G_img);
% end
% G_vol_file = strcat(color3d_dir,'G_histo_volume.mgz');
% mgz.vol = green_vol;
% mgz.vox2ras0 = vox2ras0;
% MRIwrite(mgz,G_vol_file);
% 
% %to save memory
% clear green_vol;
% clear mgz;

%%%%%%%

for f=1:nFiles
    B_file = strcat(color2d_dir,blue_files(f).name);
    B_img = imread(B_file);
    
    blue_vol = cat(3,blue_vol,B_img);
end
B_vol_file = strcat(color3d_dir,'B_histo_volume.mgz');
mgz.vol = blue_vol;
mgz.vox2ras0 = vox2ras0;
MRIwrite(mgz,B_vol_file);

%to save memory
clear blue_vol;
clear mgz;


%
% TODO: Applies 3D transforms 
%



