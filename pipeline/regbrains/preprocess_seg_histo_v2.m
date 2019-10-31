function preprocess_seg_histo_v2(directory,wp,bl,cl,inext)

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
%rfactor = 0.15;
rfactor = 1;
%cl = [7.9311 -1.6423 2.5663];
%bl = [67.9466 -5.7531 36.0383];


if directory(end) ~= '/'
    directory = [directory '/'];
end


block_dir = strcat(directory,'histology/orig/'); %original images
seg_dir = strcat(directory,'histology/seg/');
mkdir(seg_dir);

files = dir(strcat(block_dir,'*.',inext));
nFiles = length(files);
for f=1:nFiles    

        fprintf('Processing %s...\n',files(f).name);

        name = strcat(block_dir,files(f).name);
        img = imread(name);
        %img = imresize(img,rfactor);

        new_name = changeExt(files(f).name,'tif'); %avoid lossy compression

        new_name = strcat(seg_dir,new_name);
        %do segmentation
        try
            img2 = seg_histology_LAB(img,wp,rfactor,bl,cl);
            imwrite(img2,new_name,'TIFF');
        catch ME
            fprintf('Error in image %s.',files(f).name); 
            disp(getReport(ME,'extended'));
        end

end





