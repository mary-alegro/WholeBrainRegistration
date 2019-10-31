function posprocess_histo2block_color(root_dir)

%
% Used in full brain histology registration.
% Registers the histology slices to their corresponding block face slices.
% Uses ANTs affine transform with Mattes similarity metric
%
% ROOT_DIR : case base directory
%

if root_dir(end) ~= '/'
    root_dir = [root_dir '/'];
end

bf_dir = strcat(root_dir,'blockface/seg/');
histo_dir = strcat(root_dir,'histology/seg/');
histo_base = strcat(root_dir,'histology/');
histo_reg_dir = strcat(histo_base,'reg2d/');
color_base = strcat(histo_base,'color/');
color_seg_dir = strcat(color_base,'seg/');
color_seg_dir_R = strcat(color_seg_dir,'R/');
color_seg_dir_G = strcat(color_seg_dir,'G/');
color_seg_dir_B = strcat(color_seg_dir,'B/');
color_reg_dir = strcat(color_base,'reg2d/');
color_reg_dir_R = strcat(color_reg_dir,'R/');
color_reg_dir_G = strcat(color_reg_dir,'G/');
color_reg_dir_B = strcat(color_reg_dir,'B/');
tmp_dir = strcat(root_dir,'tmp/');


mkdir(histo_reg_dir);
mkdir(tmp_dir);
mkdir(color_reg_dir);
mkdir(color_reg_dir_R);
mkdir(color_reg_dir_G);
mkdir(color_reg_dir_B);

ext = '*.tif';
%histo_ext = '*.jpg'

files = dir(strcat(bf_dir,ext));
nFiles = length(files); %blockface and histo files should have the same name.

count = 1;
for f = 1:nFiles
    
    name = files(f).name;
    
    fprintf('Processing %s (%d of %d). \n',name,count,nFiles);
    count = count+1;
    
    name_nii = changeExt(name,'nii');
    tmp_bf = strcat(tmp_dir,name_nii);
    tmp_histo_R = strcat(tmp_dir,'h_R_',name_nii);
    tmp_histo_G = strcat(tmp_dir,'h_G_',name_nii);
    tmp_histo_B = strcat(tmp_dir,'h_B_',name_nii);
    img_bf = strcat(bf_dir,name);
    img_histo_R = strcat(color_seg_dir_R,name);
    img_histo_G = strcat(color_seg_dir_G,name);
    img_histo_B = strcat(color_seg_dir_B,name);
    
    idx = strfind(name,'.');
    idx = idx(end)-1;
    name_noext = name(1:idx);
    ants_prefix = strcat(histo_reg_dir,'ants_histo2block_',name_noext,'_');

%     %convert blockface
    command = sprintf('ConvertImage 2 %s %s', img_bf, tmp_bf);
    [status_bf, result_bf] = system(command);
    if status_bf ~= 0 
        fprintf('Could no convert %s.\n', img_bf);
        return;
    end 
    %convert color histo
    command = sprintf('ConvertImage 2 %s %s', img_histo_R, tmp_histo_R);
    [status_h, result_h] = system(command);
    if status_h ~= 0 
        fprintf('Could no convert %s.\n', img_histo_R);
        return;
    end 
    command = sprintf('ConvertImage 2 %s %s', img_histo_G, tmp_histo_G);
    [status_h, result_h] = system(command);
    if status_h ~= 0 
        fprintf('Could no convert %s.\n', img_histo_G);
        return;
    end 
    command = sprintf('ConvertImage 2 %s %s', img_histo_B, tmp_histo_B);
    [status_h, result_h] = system(command);
    if status_h ~= 0 
        fprintf('Could no convert %s.\n', img_histo_B);
        return;
    end 
     
    %img_out = strcat(histo_reg_dir,'ants_histo2block_',name);
    img_out_R = strcat(color_reg_dir_R,'ants_histo2block_',name_nii);
    img_out_G = strcat(color_reg_dir_G,'ants_histo2block_',name_nii);
    img_out_B = strcat(color_reg_dir_B,'ants_histo2block_',name_nii);
    %tmp_img_out = strcat(tmp_dir,'ants_histo2block_',name_nii);

    %
    % apply transform and convert back to TIFF
    %
    %antsApplyTransforms -d 2 -i histo.tif -r block.tif -n linear -t ants_204h0GenericAffine.mat -o ants_histo.tif
    %ConvertImagePixelType $out ${outp}.tif 1
    xform = strcat(ants_prefix,'0GenericAffine.mat');
    command = sprintf('antsApplyTransforms -d 2 -i %s -r %s -n linear -t %s -o %s',tmp_histo_R,tmp_bf,xform,img_out_R);
    [status_ants, result_ants] = system(command);
    if status_ants ~= 0 
        fprintf('Could not run antsApplyTransforms on  %s.\n', tmp_histo_R);
        return;
    end 
    command = sprintf('antsApplyTransforms -d 2 -i %s -r %s -n linear -t %s -o %s',tmp_histo_G,tmp_bf,xform,img_out_G);
    [status_ants, result_ants] = system(command);
    if status_ants ~= 0 
        fprintf('Could not run antsApplyTransforms on  %s.\n', tmp_histo_G);
        return;
    end 
    command = sprintf('antsApplyTransforms -d 2 -i %s -r %s -n linear -t %s -o %s',tmp_histo_B,tmp_bf,xform,img_out_B);
    [status_ants, result_ants] = system(command);
    if status_ants ~= 0 
        fprintf('Could not run antsApplyTransforms on  %s.\n', tmp_histo_B);
        return;
    end 

end