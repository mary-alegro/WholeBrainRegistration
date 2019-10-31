function apply_masks(directory,type,new_size,ext)

%
% Apply existing segmentation masks
% DIRECTORY: case root directory
% TYPE: 'histo'or 'block'
% NEW_SIZE: rescale rate/new size of the original image.  -1: do nothing. Ex. new_size = 0.5 ou
% new_size = [100 100]. The program matches the mask size with the new
% image size.
%

if directory(end) ~= '/'
    directory = [directory '/'];
end

doResize = 1;
if length(new_size) == 1 && new_size == -1
    doResize = 0;
end

if ~exist('ext')
    ext = 'jpg';
end
    

if strcmp(type,'histo')
    orig_dir = strcat(directory,'histology/orig/');
    seg_dir = strcat(directory,'histology/seg/');
    mask_dir = strcat(directory,'histology/seg/masks/');
elseif strcmp(type,'block')
    orig_dir = strcat(directory,'blockface/orig/');
    seg_dir = strcat(directory,'blockface/seg/');
    mask_dir = strcat(directory,'blockface/seg/masks/');
elseif strcmp(type,'color')
    orig_dir = strcat(directory,'histology/orig/');
    seg_dir = strcat(directory,'histology/color/seg/');
    seg_dir_R = strcat(directory,'histology/color/seg/R/');
    seg_dir_G = strcat(directory,'histology/color/seg/G/');
    seg_dir_B = strcat(directory,'histology/color/seg/B/');
    mask_dir = strcat(directory,'histology/seg/masks/');
    mkdir(seg_dir);
    mkdir(seg_dir_R);
    mkdir(seg_dir_G);
    mkdir(seg_dir_B);
    iscolor = 1;
else
    error('TYPE must be "histo", "block" or "color"');
end

files = dir(strcat(mask_dir,'*.tif'));
nFiles = length(files);
for f=1:nFiles
    
    mask_name = strcat(mask_dir,files(f).name);
    mask = imread(mask_name);
    orig_name = strcat(orig_dir,changeExt(files(f).name,ext));
    img = imread(orig_name);
    
    if doResize
        if length(new_size) == 1
            img = imresize(img,new_size);
        else
            img = imresize(img,[new_size(1) new_size(2)]);
        end
    end
    
    [r c N] = size(img);
    mask = imresize(mask,[r c]);
    seg_name = strcat(seg_dir,files(f).name);
    
    if(N > 1 && iscolor == 0)
        img = rgb2gray(img);
        img(mask == 0) = 0;
    else
        R = img(:,:,1);
        G = img(:,:,2);
        B = img(:,:,3);
        R(mask == 0) = 0;
        G(mask == 0) = 0;
        B(mask == 0) = 0;
        img = cat(3,R,G,B);
        
        seg_name_R = strcat(seg_dir_R,files(f).name);
        seg_name_G = strcat(seg_dir_G,files(f).name);
        seg_name_B = strcat(seg_dir_B,files(f).name);
        
        imwrite(R,seg_name_R,'TIFF');
        imwrite(G,seg_name_G,'TIFF');
        imwrite(B,seg_name_B,'TIFF');
    end
    
    imwrite(img,seg_name,'TIFF');
end


 