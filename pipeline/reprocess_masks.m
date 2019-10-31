function reprocess_masks(directory)

files = dir(strcat(directory,'/mask/*_mask.tif'));
nFiles = length(files);
mask_ext = '_mask.tif';
seg_dir = strcat(directory,'/seg');

for f = 1:nFiles   
    
    ind = findstr(files(f).name,mask_ext);
    name = files(f).name(1:ind-1);    
    img_name = strcat(directory,'/',name);     
    image = imread(img_name);
    image = imresize(image,0.25);
    
    mask_name = strcat(directory,'/mask/',files(f).name);    
    mask = imread(mask_name);
    
    %finds most important object in mask file
    mask = fix_mask(mask);
    
    %segment
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);

    R(mask == 0) = 0;
    G(mask == 0) = 0;
    B(mask == 0) = 0;

    seg_img = cat(3,R,G,B);    
 
    seg_img_name = strcat(seg_dir,'/',name);    
    imwrite(seg_img,seg_img_name,'TIFF');   
    imwrite(mask,mask_name,'TIFF');
    
end 