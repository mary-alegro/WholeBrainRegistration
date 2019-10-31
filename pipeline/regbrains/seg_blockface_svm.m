function image = seg_blockface_svm(img, wp, model)

% Segments block images.
%
% IMG: image to be segmented
% WP: point of whitest color, for white balance
% HULL: 1: initialize snakes with mask convexhull
% NITER : no. iteration for snakes (won't use snakes if empty)
% RBACK: 1: is removing backgroung. 0: refinement
% MUPT : list of points for tissue (optional)
%        one point per row ([rows cols])
% MUPB : list of points for background (optional)        
%       one point per row ([rows cols])

wsize = 13;

% if rback == 1
%     img = imresize(img,0.15);
% end
if rback ~= 1
    R = img(:,:,1);
    mask_back = zeros(size(R));
    mask_back(R > 1) = 1;
    idx_fore = find(mask_back == 1);
end

img_bck = img;
img = weak_wb(img,wp);
yiq = rgb2ntsc(img);
Y = yiq(:,:,1);
I = yiq(:,:,2);
Q = yiq(:,:,3);
%[H S V] = rgb2hsv(img);

[rows cols] = size(Y);
img_center = [round(rows/2) round(cols/2)];


if rback == 1
    features = double(cat(2,I(:),Q(:)));
    %features = double(cat(2,S(:),V(:)));    
else
    features = double(cat(2,I(idx_fore),Q(idx_fore)));     
end

labels = zeros(features,1);

[classes, prec, prob] = svmpredict(labels, features, model);

mask = zeros(size(Y));
mask(classes == 1) = 1;




