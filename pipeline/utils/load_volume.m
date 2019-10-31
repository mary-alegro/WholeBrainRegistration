function volume = load_volume(directory,type)

%
% DIRECTORY : file location
% TYPE : 1 = TIFF | 2 = JPG
%

if type == 1
    ext = '/*.tif';
elseif type == 2
    ext = '/*.jpg';
elseif type == 3
    ext = '/*.nii';
end

files = dir(strcat(directory,ext));
files = sortfiles(files);
nFiles = length(files);

volume = [];

for f = 1:nFiles   
    img_name = strcat(directory,'/',files(f).name); 
       
    img = imread(img_name);
    [r c N] = size(img);
    
    %turn to gray 
    if N > 1
        img = rgb2gray(img);
    end
    
    try
        volume = cat(3, volume,img);
    catch
        fprintf('Erro na image: %s\n',files(f).name);
    end
end

end



