function build_blockface_volume(direc, vox_size)

if direc(end) ~= '/'
    direc = [direc '/'];
end

if direc(end) ~= '/'
    direc = [direc '/'];
end

ext = '.tif';
seg_dir = strcat(direc,'blockface/seg/');
vol_dir = strcat(seg_dir,'volume/');
mkdir(vol_dir);

files = dir(strcat(seg_dir,'*',ext));
%files = sortfiles(files);
nFiles = length(files);

volume = [];

fprintf('Loading files...\n');
for f=1:nFiles
    name = strcat(seg_dir,files(f).name);
    img = imread(name);
    volume = cat(3, volume, img);
end

fprintf('Writing MGZ...\n');
mgz.vol = volume;
mgz_name = strcat(vol_dir,'block_volume.mgz');
MRIwrite(mgz,mgz_name);

%set voxel size
if ~isempty(vox_size)
    fprintf('Setting MGZ vox2ras0...\n');
    mgz = MRIread(mgz_name);
    x = vox_size(1);
    y = vox_size(2);
    z = vox_size(3);
    M = [x 0 0 0; 0 y 0 0; 0 0 z 0; 0 0 0 1];
    mgz.vox2ras0 = mgz.vox2ras0*M;
    MRIwrite(mgz,mgz_name);
end