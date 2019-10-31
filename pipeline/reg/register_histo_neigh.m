function register_histo_neigh(directory)

type wrapper.m;
seg_dir = strcat(directory,'/seg/');
reg_dir = strcat(directory,'/reg_neigh/');
mkdir(reg_dir);

files = dir(strcat(seg_dir,'*.tif'));
nFiles = length(files);
files = sortfiles(files);

nNe = 2;

tmp = improcess(strcat(seg_dir,files(1).name));
[r c] = size(tmp);
volume = zeros(r,c,nFiles);

for t = 1:nFiles
    
    mov_img_name = strcat(seg_dir,files(t).name);    
    mov_img = improcess(mov_img_name);
    
    fprintf('Processing %s.\n', files(t).name);
    
  
    for n = 1:nNe
        % -n neighbor
        indL = t - n;
        if (indL > 0)
            close all;
            fprintf('   -%d (%s).\n',n, files(indL).name);
            if(max(volume(:,:,indL)) == 0)
                ref_img_name = strcat(seg_dir,files(indL).name);
                ref_img = improcess(ref_img_name);
            else
                ref_img = volume(:,:,indL);
            end            
            mov_img = register(ref_img,mov_img);  
        end
           
        % +n neighbor
        indR = t + n;
        if (indR < nFiles)   
            close all;
            fprintf('   +%d (%s).\n',n, files(indR).name);
            if(max(volume(:,:,indR)) == 0)
                ref_img_name = strcat(seg_dir,files(indR).name);
                ref_img = improcess(ref_img_name);
            else
                ref_img = volume(:,:,indR);
            end
            mov_img = register(ref_img,mov_img); 
        end
    end    
   
    volume(:,:,t) = mov_img;
    imwrite(gscale(mov_img),strcat(reg_dir,files(t).name),'TIFF');   
end








end

%useful pre processing
function img = improcess(img_name)

    img = imread(img_name);
    img = rgb2gray(img);
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




