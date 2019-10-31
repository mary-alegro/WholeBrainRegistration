function volume = mgz2slice(directory)


files = dir(strcat(directory,'/*.mgz'));
files = sortfiles(files);
nFiles = length(files);

volume = [];

for f = 1:nFiles   
    img_name = strcat(directory,'/',files(f).name);    
    idx = strfind(img_name,'.mgz');
    tmp_name = img_name(1:idx-1);
    tif_name = strcat(tmp_name,'.tif');
    %img = imread(img_name);
    mgz = MRIread(img_name);
    img = mgz.vol;
    %[r c N] = size(img);   
    
    imwrite(gscale(img),tif_name,'TIFF');
end

