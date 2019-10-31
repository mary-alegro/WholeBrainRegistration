function volume = load_mgz_volume(directory)


files = dir(strcat(directory,'/*.mgz'));
files = sortfiles(files);
nFiles = length(files);

volume = [];

for f = 1:nFiles   
    img_name = strcat(directory,'/',files(f).name);    
    %img = imread(img_name);
    mgz = MRIread(img_name);
    img = mgz.vol;
    %[r c N] = size(img);   
    
    try
        volume = cat(3, volume,img);
    catch
        fprintf('Erro na image: %s\n',files(f).name);
    end
end

