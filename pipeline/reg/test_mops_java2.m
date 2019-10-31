function test_mops_java2(directory)

seg_dir = strcat(directory,'/seg/');
files = dir(strcat(seg_dir,'*.tif'));
nFiles = length(files);




for f=1:nFiles-1
    
    close all;
    
    ref_img_name = files(f).name;
    ref_img_name = strcat(seg_dir,ref_img_name);
    ref_img = improcess(ref_img_name);
    
    mov_img_name = files(f+1).name;
    mov_img_name = strcat(seg_dir,mov_img_name);
    mov_img = improcess(mov_img_name);        
    
    mov_img2 = pre_register_mops(ref_img,mov_img);    
    
    subplot(1,3,1);
    imshow(gscale(ref_img));    
    subplot(1,3,2);
    imshow(gscale(mov_img));
    subplot(1,3,3);
    imshow(gscale(mov_img2));    
    
end

end




function img = improcess(img_name)

    img = imread(img_name);
    img = rgb2gray(img);
    
    mask = img;
    mask(mask ~= 0) = 1;
    
    img = adapthisteq(img);
    img(mask == 0) = 0;
    
    img = imresize(img,0.5);    
    img = double(img);

end