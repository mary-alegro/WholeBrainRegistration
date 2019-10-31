function fixHisto

direc = '/autofs/space/hercules_001/users/malegro/Brains/Case01/histology/seg/';
    
files = dir(strcat(direc,'*.tif'));
nFiles = length(files);

for f=1:nFiles    
    name = strcat(direc,files(f).name);
    
    fprintf('Processing %s...\n',files(f).name);
    
    img = imread(name);
    %img2 = imresize(img,0.7630);
    %img3 = imresize(img2,0.10);    
    
    img2 = adapthisteq(img);
    img2(img == 0) = 0;
    img3 = compress_hist_noback(img2);
    img3(img == 0) = 0;
    
    imwrite(img3,name,'TIFF');
end