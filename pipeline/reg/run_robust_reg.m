function run_robust_reg(directory, useRevOrder)

seg_dir = strcat(directory,'/seg/gray');
reg_dir = strcat(directory,'/robust_reg');

mkdir(reg_dir);

files = dir(strcat(seg_dir,'/*.mgz'));
nFiles = length(files);
files = sortfiles(files);

mid_idx = round(nFiles/2);

ref_img = strcat(seg_dir,'/',files(mid_idx).name);
%copy image file
copyfile(ref_img,strcat(reg_dir,files(mid_idx).name));

%register
for f=(mid_idx-1):-1:1
    mov_img = strcat(seg_dir,'/',files(f).name);
    
    idx = strfind(files(f).name,'.');
    nii_name = strcat(files(f).name(1:idx(end)),'nii');
    
    mov_img_new = strcat(reg_dir,'/',nii_name);
    lta_name = strcat(reg_dir,'/',files(f).name,'.lt');
    
    %command = strcat('mri_robust_register --mov ',mov_img,' --dst ', ref_img, ' --mapmov ',  mov_img_new, ' --iscale --satit');
    command = sprintf('mri_robust_register --mov %s --dst %s --lta %s --mapmov %s --iscale --satit',mov_img,ref_img,lta_name,mov_img_new);
    
    %run mri_robust_img command
    %eval(command);
    [status, result] = system(command);
    if status ~= 0
        fprintf('Error!\n');
        %exit;
    end
    
    ref_img = mov_img_new;
end

ref_img = strcat(seg_dir,'/',files(mid_idx).name);
%copy image file
copyfile(ref_img,strcat(reg_dir,files(mid_idx).name));

%register
for f=(mid_idx+1):1:nFiles
    mov_img = strcat(seg_dir,'/',files(f).name);
    
    idx = strfind(files(f).name,'.');
    nii_name = strcat(files(f).name(1:idx(end)),'nii');    
    
    mov_img_new = strcat(reg_dir,'/',nii_name);
    lta_name = strcat(reg_dir,'/',files(f).name,'.lta');
    
    %command = strcat('mri_robust_register --mov ',mov_img,' --dst ', ref_img, ' --mapmov ',  mov_img_new, ' --iscale --satit');
    command = sprintf('mri_robust_register --mov %s --dst %s --lta %s --mapmov %s --iscale --satit',mov_img,ref_img,lta_name,mov_img_new);
    
    %run mri_robust_img command
    %eval(command);
    [status, result] = system(command);
    if status ~= 0
        fprintf('Error!\n');
        %exit;
    end
    
    ref_img = mov_img_new;
end

%assemble final volume
files = dir(strcat(reg_dir,'/*.nii'));
files = sortfiles(files);
nFiles = length(files);

if useRevOrder == 0
    volume = [];
    final_vol = [];
    for f=1:nFiles
        %mgz = MRIread(strcat(reg_dir,'/',files(f).name));
        mgz = load_nifti(strcat(reg_dir,'/',files(f).name));
        volume = cat(3,volume,mgz.vol);
        final_vol = mgz;
    end
else
    volume = reverse_stack(reg_dir,1,1);
end

final_vol.vol = volume;
MRIwrite(final_vol,strcat(reg_dir,'/mrr_final_reg.mgz'));
