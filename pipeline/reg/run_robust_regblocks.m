function run_robust_regblocks(directory)

seg_dir = strcat(directory,'/seg/gray');
reg_dir = strcat(directory,'/robust_reg');

mkdir(reg_dir);

files = dir(strcat(seg_dir,'/*.mgz'));
%nFiles = length(files);
%files = sortfiles(files);
nBlocks = numBlocks(files);

%mid_idx = round(nFiles/2);

%ref_img = strcat(seg_dir,'/',files(mid_idx).name);
%copy image file
%copyfile(ref_img,strcat(reg_dir,files(mid_idx).name));


for b = 1:nBlocks
    
    blockFiles = dir(strcat(seg_dir,'/*BL',num2str(b),'*.mgz'));
    blockFiles = sortfiles(blockFiles);
    nFiles = length(blockFiles);
    
    mid_idx = round(nFiles/2);    
    ref_img = strcat(seg_dir,'/',blockFiles(mid_idx).name);
    
    %register
    for f=(mid_idx-1):-1:1
        mov_img = strcat(seg_dir,'/',blockFiles(f).name);
        mov_img_new = strcat(reg_dir,'/',blockFiles(f).name);
        lta_name = strcat(reg_dir,'/',blockFiles(f).name,'.lta');

        %command = strcat('mri_robust_register --mov ',mov_img,' --dst ', ref_img, ' --mapmov ',  mov_img_new, ' --iscale --satit');
        command = sprintf('mri_robust_register --mov %s --dst %s --lta %s --mapmov %s --iscale --satit',mov_img,ref_img,lta_name,mov_img_new);

        %run mri_robust_img command
        [status, result] = system(command);
        if status ~= 0
            fprintf('Error!\n');
            %exit;
        end

        ref_img = mov_img_new;
    end

    ref_img = strcat(seg_dir,'/',blockFiles(mid_idx).name);
    %copy image file
    copyfile(ref_img,strcat(reg_dir,blockFiles(mid_idx).name));

    %register
    for f=(mid_idx+1):1:nFiles
        mov_img = strcat(seg_dir,'/',blockFiles(f).name);
        mov_img_new = strcat(reg_dir,'/',blockFiles(f).name);
        lta_name = strcat(reg_dir,'/',blockFiles(f).name,'.lta');

        %command = strcat('mri_robust_register --mov ',mov_img,' --dst ', ref_img, ' --mapmov ',  mov_img_new, ' --iscale --satit');
        command = sprintf('mri_robust_register --mov %s --dst %s --lta %s --mapmov %s --iscale --satit',mov_img,ref_img,lta_name,mov_img_new);

        %run mri_robust_img command
        [status, result] = system(command);
        if status ~= 0
            fprintf('Error!\n');
            %exit;
        end

        ref_img = mov_img_new;
    end
end



%assemble final volume
% files = dir(strcat(reg_dir,'/*.mgz'));
% files = sortfiles(files);
% nFiles = length(files);
% 
% volume = [];
% final_vol = [];
% for f=1:nFiles
%     mgz = MRIread(strcat(reg_dir,'/',files(f).name));
%     volume = cat(3,volume,mgz.vol);
%     final_vol = mgz;
% end
% 
% final_vol.vol = volume;
% MRIwrite(final_vol,strcat(reg_dir,'/final_reg.mgz'));

% volume = reverse_stack(reg_dir,0,'mgz');
% final_vol.vol = volume;
% MRIwrite(final_vol,strcat(reg_dir,'/final_reg.mgz'));
