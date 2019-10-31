function mri2slices(volume, dest)

%
% saves each MRI slice in a separate TIFF file
% only used for visualization
%
% VOLUME : MRI volume
% DEST: where to save the TIFF files
%

if dest(end) ~= '/'
    dest = [dest '/'];
end

[r c N] = size(volume);

for s=1:N
    
    name = strcat(dest,'mri',int2str(s),'.tif');
    img = volume(:,:,s);
    img = gscale(img);
    
    imwrite(img,name,'TIFF'); 
    
end