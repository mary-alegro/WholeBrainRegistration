function register_histo_block3(directory)

%--------------------------------------------
%
% DIRECTORY: folder with images to be registered
% 
% Uses new objective function where 3 preceeding neighboors are used.
% Concatenate transform matrix.
%
%--------------------------------------------

seg_dir = strcat(directory,'/seg/');
reg_dir = strcat(directory,'/reg_block3/');
ref_dir = strcat(reg_dir,'/ref/');
mkdir(reg_dir);
mkdir(ref_dir);

files = dir(strcat(seg_dir,'*.tif'));
nBlocks = numBlocks(files);

%number of neighboors to consider
% (in each side of reference image)
% (ref-K:ref+K)
K = 1;
nK = 2*K+1;

%automaticaly get reference file for each block
%get middle image, which is usually more "stable"
fprintf('Total Blocks: %d\n',nBlocks);
for b=1:nBlocks    
    
    blockFiles = dir(strcat(seg_dir,'*BL',num2str(b),'*.tif'));
    blockFiles = sortfiles(blockFiles);
    nBF = length(blockFiles);
    
    ref_files(b) = {blockFiles(round(nBF/2)).name};
end

%
% iterate each block
%
for b = 1:nBlocks
    
    blockFiles = dir(strcat(seg_dir,'*BL',num2str(b),'*.tif'));
    nFiles = length(blockFiles);    
   
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
    
    
    %
    % creates initial reference volume
    % K (before and after) adjacent slices are registered to the block's middle slice   
    %
    tmp1 = (ref_index-1):-1:(ref_index-K);
    tmp2 = (ref_index+1):1:(ref_index+K);
    ref_vol_idx = cat(2,tmp1,tmp2);
    nS = length(ref_vol_idx)+1;
    %mid = idivide(uint8(nS),uint8(2),'floor');
    mid = ceil(nS/2);
    
    %loads reference image
    ref_img_name = strcat(seg_dir,ref);    
    ref_img = improcess(ref_img_name);    
    [rows cols] = size(ref_img);
    imwrite(gscale(ref_img),strcat(reg_dir,ref),'TIFF'); 
    
    ref_vol = zeros(rows,cols,nS);
    ref_vol(:,:,mid) = ref_img;     
    
    dif = abs(mid-ref_index);
    
    for k = ref_vol_idx
        close all;
        
        mov_img_name = strcat(seg_dir,blockFiles(k).name); 
        mov_img = improcess(mov_img_name);
        mov_img = register(ref_img,mov_img);   
        imwrite(gscale(mov_img),strcat(reg_dir,blockFiles(k).name),'TIFF');         
        
        ref_vol(:,:,k-dif) = mov_img;
    end
    
    ref_vol2 = ref_vol(:,:,end:-1:1); %invert ref_vol
    
    %
    % register
    %
    aux1 = ref_index-(K+1):-1:1;
    aux2 = ref_index+(K+1):nFiles;      
    
    %iterate first part of the block
    for f = aux1
        close all;
       
        fprintf('\n%s\n',blockFiles(f).name);        
        mov_img_name = strcat(seg_dir,blockFiles(f).name); 
        mov_img = improcess(mov_img_name);
        
        mov_img = register2(ref_vol,mov_img);   
        imwrite(gscale(mov_img),strcat(reg_dir,blockFiles(f).name),'TIFF');        
        
        ref_vol = createVolumeFW(mov_img,ref_vol);
    end  
    
    %iterate second part of the block
    for f = aux2
        close all;
       
        fprintf('\n%s\n',blockFiles(f).name);        
        mov_img_name = strcat(seg_dir,blockFiles(f).name); 
        mov_img = improcess(mov_img_name);
        
        mov_img = register2(ref_vol2,mov_img);   
        imwrite(gscale(mov_img),strcat(reg_dir,blockFiles(f).name),'TIFF');        
        
        ref_vol2 = createVolumeBK(mov_img,ref_vol2);
    end  
    
end

% --------------------------------
%  align blocks 
% --------------------------------



if nBlocks <= 1
    return;
end

for b = 2:nBlocks
    len = blocks(b).files;
    ref_vol = [];
    for k = len:-1:len-nK        
        ref_vol = cat(3,ref_vol,blocks(b).filesk);
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


function volume = createVolumeFW(new_img,volume)
    N = size(volume,3);
    for i = (N-1):-1:1
        volume(:,:,i+1) = volume(:,:,i);
    end
    volume(:,:,1) = new_img;
end

function volume = createVolumeBK(new_img,volume)
    N = size(volume,3);
    for i = 1:N-1
        volume(:,:,i) = volume(:,:,i+1);
    end
    volume(:,:,end) = new_img;
end




