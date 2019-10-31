function volume = load_nii_volume(direc)

%
% DIREC: full path of the directory containing the images
%

files = dir(strcat(direc,'/*.nii'));
files = sortfiles(files);
nFiles = length(files);

volume = [];

for f = 1:nFiles   
    img_name = strcat(direc,'/',files(f).name);    
    %img = imread(img_name);
    %nii = load_nifti(img_name);
    nii = MRIread(img_name);
    img = nii.vol;
    
    img = (img - min(img(:)))/(max(img(:)) - min(img(:)));
    img = gscale(img);

    try
        volume = cat(3, volume,img);
    catch
        fprintf('Erro na image: %s\n',files(f).name);
    end
end

