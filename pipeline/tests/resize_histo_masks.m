function resize_histo_masks(dir_orig, dir_out, newsize)


%
% NEWSIZE = [3439 5152];
%


if dir_orig(end) ~= '/'
    dir_orig = [dir_orig '/'];
end

if dir_out(end) ~= '/'
    dir_out = [dir_out '/'];
end

files = dir(strcat(dir_orig,'*.tif'));
nFiles = length(files);

for f=1:nFiles
    
    name = files(f).name;
    
    fprintf('Processing %s\n',name);

    mask_name = strcat(dir_orig,name);
    new_name = strcat(dir_out,name);
    
    mask = imread(mask_name);
    mask = im2bw(mask);
    mask2 = imresize(mask,newsize);
    
    imwrite(mask2,new_name,'TIFF');
end