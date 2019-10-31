function img2 = seg_blockface_LAB(img,wp,rfactor,b_lab,c_lab)


%
% IMG: image to segment
% WP: white point vector in RGB (ie. wp = [248 198 167])
% RFACTOR: resize factor
% B_LAB: brain reference color vector in LAB coords (ie. bl = [])
% C_LAB: celoidin block reference color vector in LAM coords (ie. cl = []) 
%


if ~isempty(rfactor)
    img = imresize(img,rfactor);
end

img_bkp = img;
if ~isempty(wp)
    img = weak_wb(img,wp);
end

[rows cols N] = size(img);
img_center = [round(rows/2) round(cols/2)];

%transform to LAB color space
cform = makecform('srgb2lab');
LAB = applycform(im2double(img),cform);
L = LAB(:, :, 1); A = LAB(:, :, 2); B = LAB(:, :, 3); 

%get deltaE for brain color
meanL = b_lab(1) * ones(rows, cols);
meanA = b_lab(2) * ones(rows, cols);
meanB = b_lab(3) * ones(rows, cols);

dL = L - meanL;
dA = A - meanA;
dB = B - meanB;

dE = sqrt(dL .^ 2 + dA .^ 2 + dB .^ 2);

b_dE = mat2gray(dE);
b_dE = im2double(b_dE);

%get deltaE for celoidin block color
meanL = c_lab(1) * ones(rows, cols);
meanA = c_lab(2) * ones(rows, cols);
meanB = c_lab(3) * ones(rows, cols);

dL = L - meanL;
dA = A - meanA;
dB = B - meanB;

dE = sqrt(dL .^ 2 + dA .^ 2 + dB .^ 2);

c_dE = mat2gray(dE);
c_dE = im2double(c_dE);

%create brain mask
level = graythresh(b_dE);
maskB = im2bw(b_dE,level);
maskB = imcomplement(maskB);

%create block mask
level = graythresh(c_dE);
maskC = im2bw(c_dE,level);
maskC = imcomplement(maskC);

%erase pixels that belong to the block.
maskB2 = maskB;
maskB2(maskC == 1) = 0;

%clean small objects
se = strel('disk', 10);
maskB2 = imopen(maskB2,se);
maskB2 = imclose(maskB2,se);
maskB2 = imfill(maskB2,'holes');

% [labels mainL] = findMainObj(maskB2,img_center);
% mask = zeros(size(labels));
% mask(labels == mainL) = 1;

mask = maskB2;

mask = imdilate(mask,se);
mask = region_seg(c_dE,mask,200);
mask = imfill(mask,'holes');
%mask = imopen(mask,se);

R = img_bkp(:,:,1); G = img_bkp(:,:,2); B = img_bkp(:,:,3);
R(mask == 0) = 0;
G(mask == 0) = 0;
B(mask == 0) = 0;

img2 = rgb2gray(cat(3,R,G,B));


end



function [labels mainL] = findMainObj(mask, img_center)

%find connected structures
[labels nL] = bwlabel(mask);

mainL = 0;
minDist = 0;
for l = 1:nL
    [r,c] = find(labels == l);
    sizeObj = length(find(labels == l));
    centroid = [round(mean(r))  round(mean(c))];
    
    %plot(centroid(2),centroid(1),'Marker','*','MarkerSize',10,'MarkerEdgeColor','r')
    
    dist = norm(img_center - centroid);
    if(mainL == 0) %must initialize variables
        minDist = dist;
        mainL = l;      
    end
       
    %get the largest object w/ min distance from center
    if(dist < minDist && sizeObj > 2000)
            minDist = dist;
            mainL = l;
    end 
end

end




