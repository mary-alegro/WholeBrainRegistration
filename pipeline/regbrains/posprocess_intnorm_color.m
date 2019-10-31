function posprocess_intnorm_color(direc,channel)

%
% Normalizes histology intensities
% DIREC: case directory ( direc = '/autofs/space/hercules_001/users/malegro/Brains/Case01')
% OPT: 1 - load segmented | 2 - load registered to blockface
%

if direc(end) ~= '/'
    direc = [direc '/'];
end

dir_base = strcat(direc,'histology/color/');
ext = 'nii';
if strcmp(channel,'R')
    %ext = 'nii';
    dir_histo = strcat(dir_base,'reg2d/R/');
    dir_norm = strcat(dir_base,'intnormseg/R/');
elseif strcmp(channel,'G')
    %ext = 'nii';
    dir_histo = strcat(dir_base,'reg2d/G/');
    dir_norm = strcat(dir_base,'intnormseg/G/');
elseif strcmp(channel,'B')
    %ext = 'nii';
    dir_histo = strcat(dir_base,'reg2d/B/');
    dir_norm = strcat(dir_base,'intnormseg/B/');
else
    error('CHANNEL should be "R", "G or "B".');
end


% dir_tmp = strcat(direc,'tmp/');
% r = dir(dir_tmp);
% if ~isempty(r) %veryfies tmp existence
%     rmdir(dir_tmp,'s');
% end
% mkdir(dir_tmp);
mkdir(dir_norm);


files = dir(strcat(dir_histo,'*.',ext));
nFiles = length(files);
%files = sortfiles(files);

%pick middle slice as histogram reference (middle brain images usually are pretty "stable")
 ref = round(nFiles/2);
 ref_img = strcat(dir_histo,files(ref).name);
 fprintf('Reference image: %s.\n',files(ref).name);
 %copyfile(ref_img,strcat(dir_norm,files(ref).name));


 
for f=ref:-1:1    
    
    fprintf('Processing %s.\n',files(f).name);
    
    norm_img = strcat(dir_histo,files(f).name);    
    %loads image to be corrected
    if isNifti(norm_img) || isMGZ(norm_img) 
        img1 = MRIread(norm_img);
        img1 = img1.vol;
        img1 = uint8(round(img1));  
    else
        img1 = imread(norm_img);
    end
    
    if f == ref %don't process reference image, just save it in the new dir
        new_norm_name = changeExt(files(f).name,'tif');
        new_norm_name = strcat(dir_norm,new_norm_name); 
        imwrite(img1,new_norm_name,'TIFF');
        ref_img = new_norm_name;    
        continue;
    end
    
    mask = zeros(size(img1));
    mask(img1 >= 1) = 1;  
    
    %loads reference image
    if isNifti(ref_img) || isMGZ(ref_img) 
        img2 = MRIread(ref_img);
        img2 = img2.vol;
        img2 = uint8(round(img2));  
    else
        img2 = imread(ref_img);   
    end
    
    %run intensity correction
    new_img = intensity_compensation(img1,img2);    
    %remask to avoid boundary artifacts
    new_img(mask == 0) = 0;    
    
    %save file
    new_norm_name = changeExt(files(f).name,'tif');
    new_norm_name = strcat(dir_norm,new_norm_name); 
    %if strcmp(ext,'nii') || strcmp(ext,'mgz')
    %    mgz.vol = new_img;
    %    MRIwrite(mgz,new_norm_name);
    %else
    %new_norm_name = strcat(dir_norm,files(f).name);
    imwrite(new_img,new_norm_name,'TIFF');
    %end
    
    ref_img = new_norm_name;    
end



ref_img = strcat(dir_histo,files(ref).name);
for f=ref+1:nFiles   
    
    fprintf('Processing %s.\n',files(f).name);
    
    norm_img = strcat(dir_histo,files(f).name);    
    %loads image to be corrected
    if isNifti(norm_img) || isMGZ(norm_img) 
        img1 = MRIread(norm_img);
        img1 = img1.vol;
        img1 = uint8(round(img1));  
    else
        img1 = imread(norm_img);
    end
    mask = zeros(size(img1));
    mask(img1 >= 1) = 1;  
    
    %loads reference image
    if isNifti(ref_img) || isMGZ(ref_img) 
        img2 = MRIread(ref_img);
        img2 = img2.vol;
        img2 = uint8(round(img2));  
    else
        img2 = imread(ref_img);   
    end
    
    %run intensity correction
    new_img = intensity_compensation(img1,img2);    
    %remask to avoid boundary artifacts
    new_img(mask == 0) = 0;    
    
    %save file
    new_norm_name = changeExt(files(f).name,'tif');
    new_norm_name = strcat(dir_norm,new_norm_name); 
    %if strcmp(ext,'nii') || strcmp(ext,'mgz')
    %    mgz.vol = new_img;
    %    MRIwrite(mgz,new_norm_name);
    %else
    %new_norm_name = strcat(dir_norm,files(f).name);
    imwrite(new_img,new_norm_name,'TIFF');
    %end
    
    ref_img = new_norm_name;          
end

%converts all corrected images to NIFTI
% files = dir(strcat(dir_tmp,'*.tif'));
% nFiles = length(files);
% for f=1:nFiles    
%     tmp_name = strcat(dir_tmp,files(f).name);    
%     
%     nii_name = files(f).name;
%     nii_name = changeExt(nii_name,'nii');
%     nii_name = strcat(dir_norm,nii_name);    
%     
%    command = sprintf('mri_convert %s %s', tmp_name, nii_name);
%    [status_bf, result_bf] = system(command);
%    if status_bf ~=0 
%         fprintf('Could no convert %s.\n', name);
%         return;
%    end 
% end



end



function flag = isNifti(name)
    idx = strfind(name,'.');
    idx = idx(end);
    ext = name(idx+1:end);    
    flag = strcmp(ext,'nii');    
end

function flag = isMGZ(name)
    idx = strfind(name,'.');
    idx = idx(end);
    ext = name(idx+1:end);    
    flag = strcmp(ext,'mgz');    
end


