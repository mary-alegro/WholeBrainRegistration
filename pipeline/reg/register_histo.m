function register_histo(directory)

type wrapper.m;
seg_dir = strcat(directory,'/seg/');
reg_dir = strcat(directory,'/reg/');
mkdir(reg_dir);

files = dir(strcat(seg_dir,'*.tif'));
nBlocks = numBlocks(files);

fprintf('Total Blocks: %d\n',nBlocks);
%get reference file for each block
for f=1:nBlocks
    fprintf('Block #%d\n',f);
    ref = input('Reference file:','s'); 
    ref_files(f) = {ref};
end




%iterate histological blocks
for b = 1:nBlocks
    
    blockFiles = dir(strcat(seg_dir,'*BL',num2str(b),'*.tif'));
    nFiles = length(blockFiles);
    
    
    %fprintf('Block #%d\n',b);
    %ref = input('Reference file:','s');    
    ref = cell2mat(ref_files(b));
    fprintf('Processing Block #%d\n Reference File: %s.\n',b,ref);
    
    %sort filenames
    blockFiles = sortfiles(blockFiles);
    
    
    %find position in file array
    ref_index = 0;
    for f = 1:nFiles
        if strcmp(ref,blockFiles(f).name)
            ref_index = f;
        end
    end
    
    %wrong file name
    if ref_index == 0
        fprintf('File %s not found!\n',ref);
        break;
    end
    
    aux1 = ref_index-1:-1:1;
    aux2 = ref_index+1:nFiles;
    
    
    %process reference image
    ref_img_name = strcat(seg_dir,ref);    
    ref_img = improcess(ref_img_name);
    ref_img2 = improcess(ref_img_name);
    imwrite(gscale(ref_img),strcat(directory,'/reg/',ref),'TIFF');

    
    %iterate first part of block files
    for f = aux1  %move backwards thru the file vector   
        close all;
       
        fprintf('\n%s\n',blockFiles(f).name);        
        mov_img_name = strcat(seg_dir,blockFiles(f).name);
        mov_img = improcess(mov_img_name);      
        mov_img = register(ref_img,mov_img);        
        imwrite(gscale(mov_img),strcat(directory,'/reg/',blockFiles(f).name),'TIFF');
        ref_img = mov_img;    
    end    
    
    %iterate second part of block files
    %ref_img = ref_img2;
    for f = aux2      
        close all;        
    
        fprintf('\n%s\n',blockFiles(f).name);        
        mov_img_name = strcat(seg_dir,blockFiles(f).name);        
        mov_img = improcess(mov_img_name);      
        mov_img = register(ref_img2,mov_img);        
        imwrite(gscale(mov_img),strcat(directory,'/reg/',blockFiles(f).name),'TIFF');
        ref_img2 = mov_img;    
    end     
    
end




end

%useful pre processing
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




