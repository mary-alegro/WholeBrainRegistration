function register_histo_block(directory,svref)

%
% directory: folder with images to be registered
% svref: flag for saving ref images. 0=no/1=yes
%


type wrapper.m;
seg_dir = strcat(directory,'/seg/');
reg_dir = strcat(directory,'/reg_block/');
ref_dir = strcat(reg_dir,'/ref/');
mkdir(reg_dir);
mkdir(ref_dir);

files = dir(strcat(seg_dir,'*.tif'));
nBlocks = numBlocks(files);

fprintf('Total Blocks: %d\n',nBlocks);
%automaticaly get reference file for each block
%get middle image, which is usually more "stable"
for b=1:nBlocks    
    
    blockFiles = dir(strcat(seg_dir,'*BL',num2str(b),'*.tif'));
    blockFiles = sortfiles(blockFiles);
    nBF = length(blockFiles);
    
    ref_files(b) = {blockFiles(round(nBF/2)).name};
end


%iterate through each blocks
for b = 1:nBlocks
    
    blockFiles = dir(strcat(seg_dir,'*BL',num2str(b),'*.tif'));
    nFiles = length(blockFiles);
    
    
    %fprintf('Block #%d\n',b);
    %ref = input('Reference file:','s');    
    ref = cell2mat(ref_files(b));
    fprintf('Processing Block #%d\n Reference File: %s.\n',b,ref);
    
    %sort filenames
    blockFiles = sortfiles(blockFiles);    
    blocks(b).files = blockFiles;    
    
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
    
    %lenRef = length(find(ref_img ~= 0));
    
    imwrite(gscale(ref_img),strcat(reg_dir,ref),'TIFF');
    if svref == 1
          imwrite(gscale(ref_img),strcat(ref_dir,'ref_',ref),'TIFF');
    end

    
    %iterate first part of block files
    for f = aux1  %move backwards thru the file vector   
        close all;
       
        fprintf('\n%s\n',blockFiles(f).name);        
        mov_img_name = strcat(seg_dir,blockFiles(f).name);
        
        mov_img = improcess(mov_img_name);
        
        %register
        mov_img = register(ref_img,mov_img);  
        if svref == 1
            imwrite(gscale(ref_img),strcat(ref_dir,'ref_',blockFiles(f).name),'TIFF');
        end
        imwrite(gscale(mov_img),strcat(reg_dir,blockFiles(f).name),'TIFF');
        ref_img = mov_img;    
    end    
    
    %iterate second part of block files
    %ref_img = ref_img2;
    for f = aux2      
        close all;        
    
        fprintf('\n%s\n',blockFiles(f).name);        
        mov_img_name = strcat(seg_dir,blockFiles(f).name);
        
        mov_img = improcess(mov_img_name); 
        
        %register
        mov_img = register(ref_img2,mov_img);    
        if svref == 1
            imwrite(gscale(ref_img2),strcat(ref_dir,'ref_',blockFiles(f).name),'TIFF');
        end
        imwrite(gscale(mov_img),strcat(reg_dir,blockFiles(f).name),'TIFF');
        ref_img2 = mov_img;    
    end     
    
    
end


%align blocks
for b=2:nBlocks    
    
    close all;
    ref_img_name = blocks(b-1).files(end).name;
    ref_img_name = strcat(reg_dir,ref_img_name);
    ref_img = double(imread(ref_img_name));
    
    mov_img_name = blocks(b).files(1).name;
    mov_img_name = strcat(reg_dir,mov_img_name);    
    mov_img = double(imread(mov_img_name));
    
    %register first image and compute transform
    [mov_img T] = register(ref_img,mov_img);
    imwrite(gscale(mov_img),mov_img_name,'TIFF');
    
    blockFiles = blocks(b).files;
    nFiles = length(blockFiles);
    
    for f = 2:nFiles
        
        mov_img_name = blockFiles(f).name;
        mov_img_name = strcat(reg_dir,mov_img_name); 
        mov_img = double(imread(mov_img_name));
        %apply same transform for all blocks
        mov_img = image_transform(mov_img,T);
        imwrite(gscale(mov_img),mov_img_name,'TIFF');
    end    
    
end

%align blocks
    
    

%propagate to othes blocks from head to tail
    ref_img_name = blocks(1).files(end).name;
    ref_img_name = strcat(reg_dir,ref_img_name);
    ref_img = double(imread(ref_img_name));
    
for b=2:nBlocks
    
        close all;
    
    nFiles = length(blocks(b).files);
    
    for f = 1:nFiles
        
        close all;
    
        mov_img_name = blocks(b).files(f).name;
        mov_img_name = strcat(reg_dir,mov_img_name);    
        mov_img = double(imread(mov_img_name));    
       
        [mov_img T] = register(ref_img,mov_img);
        imwrite(gscale(mov_img),mov_img_name,'TIFF');
        ref_img = mov_img;
    

    end    
    
end




%propagate to othes blocks from tail to head
    ref_img_name = blocks(nBlocks).files(1).name;
    ref_img_name = strcat(reg_dir,ref_img_name);
    ref_img = double(imread(ref_img_name));
    
for b=(nBlocks-1):-1:1
    
        close all;
    
    nFiles = length(blocks(b).files);
    
    for f = nFiles:-1:1
        
        close all;
    
        mov_img_name = blocks(b).files(f).name;
        mov_img_name = strcat(reg_dir,mov_img_name);    
        mov_img = double(imread(mov_img_name));    
       
        [mov_img T] = register(ref_img,mov_img);
        imwrite(gscale(mov_img),mov_img_name,'TIFF');
        ref_img = mov_img;
    

    end    
    
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

function m = istagged(name)
    m = 0;
    if name(1) == 'x'
        m = 1;
    end
end




