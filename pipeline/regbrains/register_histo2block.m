function register_histo2block(root_dir)

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
tmp_dir = strcat(root_dir,'tmp/');

mkdir(histo_reg_dir);
mkdir(tmp_dir);

ext = '*.tif';
%histo_ext = '*.jpg';

files = dir(strcat(bf_dir,ext));
nFiles = length(files); %blockface and histo files should have the same name.

count = 1;
for f = 1:nFiles
    
    name = files(f).name;
    
    fprintf('Processing %s (%d of %d). \n',name,count,nFiles);
    count = count+1;
    
    name_nii = changeExt(name,'nii');
    tmp_bf = strcat(tmp_dir,name_nii);
    tmp_histo = strcat(tmp_dir,'h_',name_nii);
    img_bf = strcat(bf_dir,name);
    img_histo = strcat(histo_dir,name);
    
    idx = strfind(name,'.');
    idx = idx(end)-1;
    name_noext = name(1:idx);
    ants_prefix = strcat(histo_reg_dir,'ants_histo2block_',name_noext,'_');

    %convert blockface
    command = sprintf('ConvertImage 2 %s %s', img_bf, tmp_bf);
    [status_bf, result_bf] = system(command);
    if status_bf ~= 0 
        fprintf('Could no convert %s.\n', img_bf);
        return;
    end 
    %convert histo
    command = sprintf('ConvertImage 2 %s %s', img_histo, tmp_histo);
    [status_h, result_h] = system(command);
    if status_h ~= 0 
        fprintf('Could no convert %s.\n', img_histo);
        return;
    end 
     
    %img_out = strcat(histo_reg_dir,'ants_histo2block_',name);
    img_out = strcat(histo_reg_dir,'ants_histo2block_',name_nii);
    tmp_img_out = strcat(tmp_dir,'ants_histo2block_',name_nii);
    %
    % run 2D affine registration
    %
    %antsRegistration -d 2 -r [080.nii,080h.nii,1] -m mattes[080.nii,080h.nii,1,32] -t affine[0.10] -c 100x10x10 -s 4x2x1vox -f 3x3x1 -l 1 -o ants_080h
    %antsRegistration -d 2 -r [$ref,$mov,1] \
	%		-m meansquares[$ref,$mov,1,32] -t affine[0.10] -c 10000x1100x100 -s 4x2x1vox -f 3x3x1 -l 1 \
	%		-m mattes[$ref, $mov, 1,32] -t SyN[0.15] -c 30x30x20 -s 3x3x1vox -f 4x2x2 -l 1 \
    command = sprintf('antsRegistration -d 2 -r [%s,%s,1] -m mattes[%s,%s,1,32] -t affine[0.10] -c 100x10x10 -s 4x2x1vox -f 3x3x1 -l 1 -o %s',tmp_bf,tmp_histo,tmp_bf,tmp_histo,ants_prefix);
    [status_ants, result_ants] = system(command);
    if status_ants ~= 0 
        fprintf('Could not run antsRegistration on  %s.\n', tmp_histo);
        return;
    end 
    %
    % apply transform and convert back to TIFF
    %
    %antsApplyTransforms -d 2 -i histo.tif -r block.tif -n linear -t ants_204h0GenericAffine.mat -o ants_histo.tif
    %ConvertImagePixelType $out ${outp}.tif 1
    xform = strcat(ants_prefix,'0GenericAffine.mat');
    command = sprintf('antsApplyTransforms -d 2 -i %s -r %s -n linear -t %s -o %s',tmp_histo,tmp_bf,xform,img_out);
    [status_ants, result_ants] = system(command);
    if status_ants ~= 0 
        fprintf('Could not run antsApplyTransforms on  %s.\n', tmp_histo);
        return;
    end 
%     command = sprintf('ConvertImage 2 %s %s',tmp_img_out,img_out);
%     [status_ants, result_ants] = system(command);
%     if status_ants ~= 0 
%         fprintf('Could not ConvertImage on  %s.\n', tmp_histo);
%          return;
%     end 
end