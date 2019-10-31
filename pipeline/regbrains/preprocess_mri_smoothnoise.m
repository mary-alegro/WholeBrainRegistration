function preprocess_mri_smoothnoise(direc,file,params)

%
% Applies anisotropic diffusion to smooth MRI noise
% OBS: Use this before upsamplig the MRI, since anisodiff3D works better
% with isotropic voxels.
%
% DIREC : fullpath of the directory where the volume is located
% FILE: filename of the MRI volume to be smoothed (.nii.gz)
% PARAM: anisotropic diffusion parameters vector
%


if direc(end) ~= '/'
    direc = [direc '/'];
end

file_name = strcat(direc,file);

idx = strfind(file,'.');
idx = idx(1);
new_name = file(1:idx-1);
new_name = strcat(new_name,'_filter',file(idx:end));
new_name = strcat(direc,new_name);

mri = MRIread(file_name);
volume = mri.vol;

[r c N] = size(volume); %N assumed to be the number of slices

%anisotropic diffusion params
% num_iter = 7;
% delta_t = 3/44;
% kappa = 10;
% option = 1;
voxel_spacing = mri.volres;
num_iter = params(1);
delta_t = params(2);
kappa = params(3);
option = params(4);

%apply anisodiff
volume2 = anisodiff3D(volume, num_iter, delta_t, kappa, option, voxel_spacing);

%remask slices to ensure zero intensity background
final_vol = [];
for s = 1:N
    mask = volume(:,:,s);
    img = volume2(:,:,s);
    
    img(mask <= 1) = 0;
    final_vol = cat(3,final_vol,gscale(img));
end

mri.vol = final_vol;
MRIwrite(mri,new_name);