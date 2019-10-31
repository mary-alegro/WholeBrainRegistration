function rate = preprocess_set_colorsize(root_dir)

%
% Convert slices to grayscale and resize histology to blockface
% so that image dimensions closely match
%
% ROOT_DIR : Case base dir (i.e. /Home/User/Case01)
%
% RATE : resize rate used for scaling histology and blockface image to a
% similar size (save this value for it' necessary in
% posprocess_histo_color_2D(...))
%

if root_dir(end) ~= '/'
    root_dir = [root_dir '/'];
end


bf_base = strcat(root_dir,'blockface/');
histo_base = strcat(root_dir,'histology/');
bf_seg = strcat(bf_base,'seg/');
histo_seg = strcat(histo_base,'seg/');
bf_color = strcat(bf_seg,'color/');
histo_color = strcat(histo_seg,'color/');

mkdir(bf_color);
mkdir(histo_color);

ext = '*.tif';

files_block = dir(strcat(bf_seg,ext));
files_block = sortfiles(files_block);
files_histo = dir(strcat(histo_seg,ext));
files_histo = sortfiles(files_histo);

if length(files_block) ~= length(files_histo)
    error('There must be the same number of histology and blockface images.');
end


nFiles = length(files_block); %files_block and files_histo must be the same size

for f = 1:nFiles
    name_block = strcat(bf_seg,files_block(f).name);
    name_histo = strcat(histo_seg,files_histo(f).name);
    
    img_block = imread(name_block);
    img_histo = imread(name_histo);
    
    %store color images
    movefile(name_block,bf_color);
    movefile(name_histo,histo_color);
    
    %convert to grayscale
    img_block = rgb2gray(img_block);
    img_histo = rgb2gray(img_histo);
   
    %resize
    sblock = size(img_block);
    shisto = size(img_histo);

    [maxv mdim] = max(sblock); %largest dimension
    
    if sblock(mdim) > shisto(mdim) %resize blockface
        rate = shisto(mdim)/sblock(mdim);
        img_block = imresize(img_block,rate);       
    elseif sblock(mdim) < shisto(mdim) %resize histo
        rate = sblock(mdim)/shisto(mdim);
        img_histo = imresize(img_histo,rate);        
    end
    imwrite(img_histo,name_histo,'TIFF');
    imwrite(img_block,name_block,'TIFF');
end
