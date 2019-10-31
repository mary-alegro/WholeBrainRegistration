function apply_ants2daffine_binmasks_histo(dir_masks,dir_block,dir_out,dir_transf)

if dir_masks(end) ~= '/'
    dir_masks = [dir_masks '/'];
end
if dir_out(end) ~= '/'
    dir_out = [dir_out '/'];
end
if dir_transf(end) ~= '/'
    dir_transf = [dir_transf '/'];
end
if dir_block(end) ~= '/'
    dir_block = [dir_block '/'];
end

dir_tmp = strcat(dir_out,'tmp/');
mkdir(dir_tmp);

shift = 11;

files = dir(strcat(dir_masks,'*.tif'));
files = sortfiles(files);
nFiles = length(files);

for f = 1:nFiles
    name = files(f).name;
    mask_name = strcat(dir_masks,name);
    t_idx = f+shift;
    transf_name = sprintf('%sants_histo2block_%03d_0GenericAffine.mat',dir_transf,t_idx);
    out_name = strcat(dir_out,name,'.nii');
    block_name = sprintf('%s%03d.tif',dir_block,t_idx);
    b_name = sprintf('%03d.tif',t_idx);
    tmp_bf = strcat(dir_tmp,b_name,'.nii');
    out_name_tif = strcat(dir_out,name);
    tmp_mask = strcat(dir_tmp,name,'.nii');
    
    % I have to convert all images to NIFTI because for some reason ANTs is
    % blowing up when I try to register TIFF images
    
    %convert blockface
    command = sprintf('ConvertImage 2 %s %s 1', block_name, tmp_bf);
    [status_bf, result_bf] = system(command);
    if status_bf ~= 0 
        fprintf('Could no convert %s.\n', block_name);
        return;
    end 
    
    %convert mask
    command = sprintf('ConvertImage 2 %s %s 1', mask_name, tmp_mask);
    [status_bf, result_bf] = system(command);
    if status_bf ~= 0 
        fprintf('Could no convert %s.\n', block_name);
        return;
    end 

    command = sprintf('antsApplyTransforms -d 2 -i %s -r %s -n linear -t %s -o %s',tmp_mask,tmp_bf,transf_name,out_name);
    [status_ants, result_ants] = system(command);
    if status_ants ~= 0 
        fprintf('Could not run antsApplyTransforms on  %s.\n', tmp_bf);
        return;
    end 
    
    %convert output binary mask to tiff
    command = sprintf('ConvertImage 2 %s %s 1', out_name, out_name_tif);
    [status_bf, result_bf] = system(command);
    if status_bf ~= 0 
        fprintf('Could no convert %s.\n', out_name);
        return;
    end 
end
