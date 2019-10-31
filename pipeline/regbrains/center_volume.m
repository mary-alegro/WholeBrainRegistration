function center_volume(vol_path,new_vol_path, M_path)


addpath('~/bin/freesurfer/matlab/');
load(M_path);
mgz = MRIread(vol_path);
mgz.vox2ras0 = mgz.vox2ras0 * M;

MRIwrite(mgz,new_vol_path);

exit;