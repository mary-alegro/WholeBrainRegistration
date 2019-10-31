function preprocess_seg_block(directory,wp,todo,do1st,samples,inext)

%
% Segments blockface image background
% DIRECTORY : case dir
% WP: coordinates for white color point example, used in white balance
% TODO: list of file for segmentation refinement. Used when much background
% was left behind.
% DO1ST:
% SAMPLE: structure with samples for GMM initialization. Improvest
% segmentation results.
% INEXT: extention of input images, Ie.: 'jpg'
%

wsize = 13;
rfactor = 0.15;



if directory(end) ~= '/'
    directory = [directory '/'];
end

init_obj = [];
if ~isempty(samples)
    
    if ~isempty(todo) %this is not the first segmentation so, images are already rescaled
        rfactor = [];
    end
    
    init_obj = init_gmm(wsize,wp,samples, rfactor);
end

block_dir = strcat(directory,'blockface/orig/'); %original images
seg_dir = strcat(directory,'blockface/seg/');
mask_dir = strcat(directory,'blockface/seg/masks/');
mkdir(seg_dir);
mkdir(mask_dir);

if isempty(todo) %first segmentation (aka main background parts)

    files = dir(strcat(block_dir,'*.',inext));
    nFiles = length(files);
    for f=1:nFiles    

        fprintf('Processing %s...\n',files(f).name);

        name = strcat(block_dir,files(f).name);
        img = imread(name);
        img = imresize(img,rfactor);

        new_name = changeExt(files(f).name,'tif'); %avoid lossy compression
        mask_name = strcat('mask_',new_name);

        new_name = strcat(seg_dir,new_name);
        mask_name = strcat(mask_dir,mask_name);
        %do segmentation
        try
            [img2 mask2] = seg_blockface_em(img,wp,1,10,1,[],[],init_obj);
            imwrite(img2,new_name,'TIFF');
            imwrite(mask2,mask_name,'TIFF');
        catch
        %    fprintf('Error in image %s.',files(f).name); 
        end

    end

else %segmentation refinement
    
   nFiles = length(todo);   
   for f = 1:nFiles  
       
       prefix = [];
       if (todo(f) <= 9)
           prefix = '00';
       elseif (todo(f) >= 10 && todo(f) <= 99)
           prefix = '0';
       end
       
       if do1st 
           name = strcat(prefix,int2str(todo(f)),'.',inext);
           new_name = changeExt(name,'tif'); %avoid lossy compression
           name = strcat(block_dir,name);           
           new_name = strcat(seg_dir,new_name);
           rback = 1;
       else
           name = strcat(prefix,int2str(todo(f)),'.tif');
           name = strcat(seg_dir,name);
           new_name = name;
           rback = 0;
       end      
       
       mask_name = strcat('mask_',prefix,int2str(todo(f)),'.tif');
       mask_name = strcat(mask_dir,mask_name);
       
       fprintf('Processing %s...\n',name);
       
       img = imread(name);
       if do1st
            img = imresize(img,rfactor);
       end
       %do segmentation
       img2 = seg_blockface_em(img,wp,1,10,rback,[],[],init_obj);
       imwrite(img2,new_name,'TIFF');
   end
end


end




