function build_histo_volume(reg_dir,vox_size)

%
% Creates 3D histology volume from the registered histo plates
% REG_DIR: directory where the target images are located
% VOXEL SIZE: voxel dimensions (e.g. [0.5 0.5 0.1])
%

if reg_dir(end) ~= '/'
    reg_dir = [reg_dir '/'];
end

ext = '.tif';
%reg_dir = strcat(reg_dir,'histology/regblock/');
vol_dir = strcat(reg_dir,'volume/');
mkdir(vol_dir);

files = dir(strcat(reg_dir,'*',ext));
%files = sortfiles(files);
nFiles = length(files);

volume = [];

fprintf('Loading files...\n');
for f=1:nFiles
    name = strcat(reg_dir,files(f).name);
    img = imread(name);
    volume = cat(3, volume, img);
end

fprintf('Writing MGZ...\n');
mgz.vol = volume;
mgz_name = strcat(vol_dir,'histo_volume.mgz');
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