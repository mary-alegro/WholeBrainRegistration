function sav_score = sav_3n(params, image1, image2)
% SAV  Sum of Absolute Value function template
%  SAV_SCORE = SAV(IMAGE1,IMAGE2) is an objective function that calculates the
%  sum of the absolute value of the intensity difference between the pixels of
%  the two input images, IMAGE1 and IMAGE2. IMAGE1 and IMAGE2 are both matrices.
%  The output SAV_SCORE is the sum of the absolute value of the intensity
%  difference.
%
%  You are responsible for updating this function to make it fully operational.
%
% PARAMS: weights for each neighboor (length must be equal size(image1,3))
%

N = size(image1,3);

sav_score = 0;
for i=1:N
    im1 = image1(:,:,i);
    sav_score = sav_score + (params(i) * sum(abs(im1(:)-image2(:))));
end

%sav_score = sum(abs(image1(:)-image2(:)));
