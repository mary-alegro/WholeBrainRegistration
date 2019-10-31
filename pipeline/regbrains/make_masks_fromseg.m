function make_masks_fromseg(directory,type)

%
% Create binary masks from previously segmented images
% DIRECTORY: case root directory
% TYPE: 'histo'or 'block'
%

if directory(end) ~= '/'
    directory = [directory '/'];
end

if strcmp(type,'histo')
    seg_dir = strcat(directory,'histology/seg/');
    mask_dir = strcat(directory,'histology/seg/masks/');
elseif strcmp (type,'block')
    seg_dir = strcat(directory,'blockface/seg/');
    mask_dir = strcat(directory,'blockface/seg/masks/');
else
    error('TYPE must be "histo" or "block"');
end

mkdir(mask_dir);

files = dir(strcat(seg_dir,'*.tif'));
nFiles = length(files);
for f=1:nFiles
    seg_name = strcat(seg_dir,files(f).name);
    img = imread(seg_name);
    mask = ones(size(img));
    mask(img == 0) = 0;
    mask = logical(mask);
    
    mask_name = strcat(mask_dir,files(f).name);
    imwrite(mask,mask_name,'TIFF');
end