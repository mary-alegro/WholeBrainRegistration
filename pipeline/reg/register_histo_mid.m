function register_histo_mid(directory)

type wrapper.m;
seg_dir = strcat(directory,'/seg/');
reg_dir = strcat(directory,'/reg_mid/');
mkdir(reg_dir);

files = dir(strcat(seg_dir,'*.tif'));
nFiles = length(files);

ref = input('Reference file:','s'); 
%process reference image
ref_img_name = strcat(seg_dir,ref);    
ref_img = improcess(ref_img_name);
%ref_img = adapthisteq(gscale(ref_img));
%ref_img = im2double(ref_img);
imwrite(gscale(ref_img),strcat(reg_dir,ref),'TIFF');



%register each file to the formely chosen reference file
for f = 1:nFiles

    close all;
    
    if strcmp(ref,files(f).name) == 1
        continue;
    end
       
    fprintf('\n%s\n',files(f).name);        
    mov_img_name = strcat(seg_dir,files(f).name);
    mov_img = improcess(mov_img_name);     
    %mov_img = adapthisteq(gscale(mov_img));
    %mov_img = im2double(mov_img);    
    mov_img = register(ref_img,mov_img);        
    imwrite(gscale(mov_img),strcat(reg_dir,files(f).name),'TIFF');    
end





end

%useful pre processing
function img = improcess(img_name)

    img = imread(img_name);
    img = rgb2gray(img);
    
    mask = img;
    mask(mask ~= 0) = 1;
    
    img = adapthisteq(img);
    img(mask == 0) = 0;
    
    img = imresize(img,0.5);    
    img = double(img);
        
    img = straighten(img); 
end



%num. blocks
function num = numBlocks(files)

n = length(files);
blocks = zeros(1,n);
for f = 1:n
    name = files(f).name;
    idx = strfind(name,'BL');
    nB = str2num(name(idx+2));
    blocks(f) = nB;
end
blocks = unique(blocks);
num = length(blocks);

end