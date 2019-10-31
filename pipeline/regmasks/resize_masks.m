function resize_masks()

%
% Downsample histology
%

mask_dir = '/home/maryana/Posdoc/Brains/Masks_AC/orig/';
%lta_dir = '/home/maryana/Posdoc/Brains/Case01/histology/reg1/';
%reg2D_dir = '/home/maryana/Posdoc/Brains/Masks_AC/reg2D/';

files = dir(strcat(mask_dir,'*.tif'));
nFiles = length(files);

for f=1:nFiles
    name = files(f).name;
    name = strcat(mask_dir,name);
    
    img = imread(name);
    img = imresize(img,[563 843]);
    
    imwrite(img,name);   
end

