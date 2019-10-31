function test_blockreg(directory)


type wrapper.m;
seg_dir = strcat(directory,'/seg/');
reg_dir = strcat(directory,'/reg_block/');

files = dir(strcat(seg_dir,'*.tif'));
nBlocks = numBlocks(files);

for b=1:nBlocks    
    
    blockFiles = dir(strcat(seg_dir,'*BL',num2str(b),'*.tif'));
    blockFiles = sortfiles(blockFiles);
    blocks(b).files = blockFiles;    
    
end


%align blocks

    
    close all;
    ref_img_name = blocks(1).files(end).name;
    ref_img_name = strcat(reg_dir,ref_img_name);
    ref_img = double(imread(ref_img_name));
    
for b=2:nBlocks    
    
    blockFiles = blocks(b).files;
    nFiles = length(blockFiles);
    
    for f = 1:nFiles
        
        close all;
    
        mov_img_name = blocks(b).files(f).name;
        mov_img_name = strcat(reg_dir,mov_img_name);    
        mov_img = double(imread(mov_img_name));

        %register first image and compute transform
        [mov_img T] = register(ref_img,mov_img);
        imwrite(gscale(mov_img),mov_img_name,'TIFF');    
        ref_img = mov_img;
    end    
    
end

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