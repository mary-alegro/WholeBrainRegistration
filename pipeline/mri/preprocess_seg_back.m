function volume = preprocess_seg_back(volume)

% Step 2:
% Segment any backgroung pixel from the rest of the image.
% VOLUME: stack of images, after N3 correction
%

N = size(volume,3);

for n = 1:N
    img = volume(:,:,n);    
    img2 = gscale(img);
    level = graythresh(img2);
    mask = im2bw(img2,level);
    %fix any hole inside the mask
    mask = tapa_buracos(mask);     
    %keep original data type
    img(mask ~= 1) = 0;
    
    volume(:,:,n) = img;
end

