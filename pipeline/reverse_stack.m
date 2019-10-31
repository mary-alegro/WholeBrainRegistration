function volume = reverse_stack(directory,revBlock,fileExt)

%
%
% revBlock : reverse block order
% 0 : don't reverse
% 1 : stack with blocks in verversed order
%
% fileExt: 
% 0 : 'tif'
% 1 : 'mgz'
%

if fileExt == 0
    ext = 'tif';
elseif fileExt == 1 
    ext = 'mgz';
end

files = dir(strcat(directory,'/*.',ext));
nBlocks = numBlocks(files);
%files = sortfiles(files);



for b=1:nBlocks

    blockFiles = dir(strcat(directory,'/*BL',num2str(b),'*.',ext));    
    blockFiles = sortfiles(blockFiles);
    nBF = length(blockFiles);

    ref_index = round(nBF/2);
    %ref_file = {blockFiles(ref_index).name};

    aux1 = ref_index-1:-1:1;
    aux2 = ref_index+1:nBF;

    %load ref image
    if fileExt == 0
        aux_vol = imread(strcat(directory,'/',blockFiles(ref_index).name));
    elseif fileExt == 1
        aux_vol = MRIread(strcat(directory,'/',blockFiles(ref_index).name));
        aux_vol = aux_vol.vol;
    end
    
    for f = aux2
        img_name = strcat(directory,'/',blockFiles(f).name);
        
        if fileExt == 0
            img = imread(img_name);
        elseif fileExt == 1
            img = MRIread(img_name);
            img = img.vol;
        end
        
        aux_vol = cat(3,img,aux_vol);
    end

    for f = aux1
        img_name = strcat(directory,'/',blockFiles(f).name);
        
        if fileExt == 0
            img = imread(img_name);
        elseif fileExt == 1
            img = MRIread(img_name);
            img = img.vol;
        end        
        
        aux_vol = cat(3,aux_vol,img);
    end

    blocks(b).vol = aux_vol;
    
end

%stack blocks
volume = [];
if revBlock == 1 %reverse block order
    for b = nBlocks:-1:1
        volume = cat(3,volume,blocks(b).vol);
    end
else
    for b = 1:nBlocks
        volume = cat(3,volume,blocks(b).vol);
    end
end

