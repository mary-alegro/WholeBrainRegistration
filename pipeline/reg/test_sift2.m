function test_sift2

img1 = imread('/autofs/space/hercules_001/users/malegro/HISTOPATO/CasosCIN/CIN038/seg/CIN 038 BL2 LAM2_0037.tif');
img2 = imread('/autofs/space/hercules_001/users/malegro/HISTOPATO/CasosCIN/CIN038/seg/CIN 038 BL2 LAM2_0038.tif');


img1 = rgb2gray(img1);
img2 = rgb2gray(img2);

img1 = adapthisteq(img1);
img2 = adapthisteq(img2);

img1 = anisodiff2D(img1,30,1/7,3,2);
img2 = anisodiff2D(img2,30,1/7,3,2);


sift_mosaic(img1,img2)