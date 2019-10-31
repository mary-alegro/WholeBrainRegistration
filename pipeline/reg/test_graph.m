function test_graph(directory)


type wrapper.m;
seg_dir = strcat(directory,'/seg/');
reg_dir = strcat(directory,'/reg_graph/');

mkdir(reg_dir);

files = dir(strcat(seg_dir,'*.tif'));
nFiles = length(files);
files = sortfiles(files);

nNe = 5;

wgraph = Inf*ones(nFiles,nFiles);
MI = Inf*ones(nFiles,nFiles);


E = 0.1;

fprintf('Building transform matrix...\n');

for i = 1:nFiles
    
    mov_img_name = strcat(seg_dir,files(i).name);
    mov_img = improcess(mov_img_name);    
    
    lim = i+nNe;
    if lim > nFiles
        lim = nFiles;
    end
    
    for j = (i+1):lim
        
        close all;
        
        ref_img_name = strcat(seg_dir,files(j).name); 
        ref_img = improcess(ref_img_name);
        [mov_img2 T] = register(ref_img,mov_img);
        
        str.T = T;
        transforms(i,j) = str;
        transforms(j,i) = str;
        
        %mi = MI2(gscale(ref_img),gscale(mov_img),'Normalized');      
        %mi = joint_entropy(ref_img,mov_img);
        mi = joint_entropy(ref_img,mov_img2);
        MI(i,j) = mi;
        MI(j,i) = mi;
    end
    
    
    
end

%load 'MI.mat';
%load 'transforms.mat';

%------------------------------------------------------
%build weight graph
%------------------------------------------------------

idxMi = find(MI ~= Inf);

maxMI = max(MI(idxMi));
minMI = min(MI(idxMi));

MMI = Inf*ones(nFiles,nFiles);

fprintf('Building weight graph...\n');

for i = 1:nFiles
    lim = i+nNe;
    if lim > nFiles
        lim = nFiles;
    end
    for j = (i+1):lim
        mmi = mapMI(MI(i,j),minMI,maxMI,0,1);
        MMI(i,j) = mmi;
        MMI(j,i) = mmi;
        w = weight(mmi,i,j,E);
        wgraph(i,j) = w;
        wgraph(j,i) = w;
    end
end

%------------------------------------------------------
%find best paths and register image
%------------------------------------------------------

ref_index = 10;

fprintf('Registering...\n');

for i=1:nFiles
    if i == ref_index
       continue;
    end
    [path cost] = dijkstra(wgraph,i,ref_index);
    mov_img_name = strcat(seg_dir,files(i).name);
    mov_img = improcess(mov_img_name);
    
    len = length(path);
    for p = 1:len-1
          T = transforms(path(p),path(p+1)).T;          
          mov_img = image_transform(mov_img,T);
    end
    
    imwrite(gscale(mov_img),strcat(reg_dir,files(i).name),'TIFF');    
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
    %img = double(img);
        
    img = straighten(img); 
end



function w = weight(nmi,i,j,e)
    
    i_j = abs(i-j);    
    w = (1+nmi)*i_j*((1+e)^i_j);

end

function  m = mapMI(v, x1, x2, y1, y2)

    m = ((y2 - y1)/(x2 - x1)) * (v - x1) + y1;

end



