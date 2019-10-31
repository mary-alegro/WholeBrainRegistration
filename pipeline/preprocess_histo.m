function preprocess_histo(directory)

files = dir(strcat(directory,'/*.tif'));
nFiles = length(files);

new_dir = strcat(directory,'/seg');
bad_mask_dir = strcat(directory,'/bad_mask');
good_mask_dir = strcat(directory,'/mask');
mkdir(new_dir);
mkdir(good_mask_dir);
mkdir(bad_mask_dir);

nError = 0;
for f = 1:nFiles
   
    img_name = strcat(directory,'/',files(f).name);    
    bad_mask_name = strcat(bad_mask_dir,'/',files(f).name,'_mask.tif');
    good_mask_name = strcat(good_mask_dir,'/',files(f).name,'_mask.tif');
    
    image = imread(img_name);
    [image mask seg_img] = histo_seg_foreground(image);
    seg_img_name = strcat(new_dir,'/',files(f).name);
    imwrite(seg_img,seg_img_name,'TIFF');
    
    res = input('Is mask ok? \n r (morph refine)/c (color seg)/Y/N [Y]:','s');    
    if ~isempty(res) && res ~= 'c' && res ~= 'r'      
        img_small = strcat(bad_mask_dir,'/',files(f).name,'_small.tif');
        imwrite(mask,bad_mask_name,'TIFF');
        imwrite(image,img_small,'TIFF');
        
        nError = nError+1;
        
    elseif(res == 'c') %try reseg w/ color
        
        close all;
        mask2 = color_seg(seg_img);
        mask2 = fix_mask(mask2);
        R = image(:,:,1);
        G = image(:,:,2);
        B = image(:,:,3);

        R(mask2 == 0) = 0;
        G(mask2 == 0) = 0;
        B(mask2 == 0) = 0;

        final_img = cat(3,R,G,B);
        
        subplot(2,1,1);
        imshow(image);
        subplot(2,1,2);
        imshow(final_img);
        
        res2 = input('Is color mask ok? Y/N [Y]:','s');
        if ~isempty(res2)        
            img_small = strcat(bad_mask_dir,'/',files(f).name,'_small.tif');
            imwrite(mask,bad_mask_name,'TIFF');
            imwrite(image,img_small,'TIFF');

            nError = nError+1;
        else            
            imwrite(mask2,good_mask_name,'TIFF');
            imwrite(final_img,seg_img_name,'TIFF');
        end
        
    elseif(res == 'r')
        
        se = strel('disk', 7);
        mask2 = imopen(mask, se);
        
        mask2 = fix_mask(mask2);
         
        close all;

        R = image(:,:,1);
        G = image(:,:,2);
        B = image(:,:,3);

        R(mask2 == 0) = 0;
        G(mask2 == 0) = 0;
        B(mask2 == 0) = 0;

        final_img = cat(3,R,G,B);
        
        subplot(2,1,1);
        imshow(image);
        subplot(2,1,2);
        imshow(final_img);
        
        res2 = input('Is refined mask ok? Y/N [Y]:','s');
        if ~isempty(res2)        
            img_small = strcat(bad_mask_dir,'/',files(f).name,'_small.tif');
            imwrite(mask,bad_mask_name,'TIFF');
            imwrite(image,img_small,'TIFF');

            nError = nError+1;
        else            
            imwrite(mask2,good_mask_name,'TIFF');
            imwrite(final_img,seg_img_name,'TIFF');
        end
        
    else
       imwrite(mask,good_mask_name,'TIFF');
       
    end  
    
    close all;    
end 
fprintf('Error: %f\n',nError/nFiles);