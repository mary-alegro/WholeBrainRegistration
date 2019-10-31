function fixBlockFace

%
% Temp. script for fixing blockface images.
%

direc = '/autofs/space/hercules_001/users/malegro/Brains/Case01/blockface/seg/';
    
files = dir(strcat(direc,'*.tif'));
nFiles = length(files);

for f=1:nFiles    
    
    fprintf('Processing %s...\n',files(f).name);
    
    name = strcat(direc,files(f).name);
    img = imread(name);
    %img2 = rgb2gray(img);
    %img3 = adapthisteq(img2);
    img2 = adapthisteq(img);
    img2(img == 0) = 0;
    img3 = compress_hist_noback(img2);
    img3(img == 0) = 0;
    imwrite(img3,name,'TIFF');
end