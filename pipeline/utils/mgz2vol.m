function mgz2vol(direc)

if direc(end) ~= '/'
    direc = [direc '/'];
end

files = dir(strcat(direc,'*.mgz'));
nFiles = length(files);

volume = [];
for f=1:nFiles
    
    mgz = MRIread(strcat(direc,files(f).name));
    
    mgz_tmp = mgz;
    
    img = mgz.vol(:,:,1);
    volume = cat(3,volume,img);    
end

mgz_tmp.vol = volume;
MRIwrite(mgz_tmp,strcat(direc,'mgz_volume.mgz'));
    

