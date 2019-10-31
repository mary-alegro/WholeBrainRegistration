function saveAsGray(directory,doHistEq)

%
% Converts all TIFF images to grayscale
% DIRECTORY : image directory 
% DOHISTEQ : histogram equalization flag (0: no ; 1: yes)
%


gray_dir = strcat(directory,'/gray');
mkdir(gray_dir);

files = dir(strcat(directory,'/*.tif'));
nFiles = length(files);

voxel = [0.08 0.08 0.09];

for f=1:nFiles
    img_name = strcat(directory,'/',files(f).name);
    img = imread(img_name);
    img2 = rgb2gray(img);

    if doHistEq == 1
        img2 = adapthisteq(img2);
    end

    idx = strfind(files(f).name,'.');
    tmp_name = files(f).name(1:idx(end));
    
    %delete empty space
    ind_space = strfind(tmp_name,' ');
    tmp_name(ind_space)=[];
    
    mgz_name = strcat(gray_dir,'/',tmp_name,'mgz');
    mgz.volres = voxel; % default histology voxel volume
    mgz.vol = img2;
    MRIwrite(mgz,mgz_name);    
end





