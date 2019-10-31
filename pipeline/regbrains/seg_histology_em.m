function image = seg_histology_em(img, wp, hull, niter, rback, mupT, mupB, init_obj, m_sigma, no_posproc)

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
% INIT_OBJ : 
% M_SIGMA: 
% NO_POSPROC: 1: just output the mask without posprocessing after classification
%

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


% imshow(img);
% hold on,
% for p=1:size(mupT,1)
%     plot(mupT(p,2),mupT(p,1),'Marker','*','MarkerSize',10,'MarkerEdgeColor','r')
% end
% for p=1:size(mupB,1)
%     plot(mupB(p,2),mupB(p,1),'Marker','*','MarkerSize',10,'MarkerEdgeColor','b')
% end


if ~isempty(mupT) && ~isempty(mupB)
    [uT covT] = getMupT(wsize,mupT,I,Q);
    [uB covB] = getMupB(wsize,mupB,I,Q);
    init_obj.mu = [uT; uB];
    init_obj.Sigma = cat(3,covT,covB);
end

if rback == 1
    features = double(cat(2,I(:),Q(:)));
    %features = double(cat(2,S(:),V(:)));    
else
    features = double(cat(2,I(idx_fore),Q(idx_fore)));     
end
%features = rescale2(features,0,1);
options = statset('Display','final');

if exist('init_obj','var') && ~isempty(init_obj)
    obj = gmdistribution.fit(features,2,'Options',options,'Start', init_obj);
else
    obj = gmdistribution.fit(features,2,'Options',options);
end
idx = cluster(obj,features);
II = features(:,1);
%QQ = features(:,2);

tmp_c1 = II(idx == 1);
tmp_c2 = II(idx == 2);
if mean(tmp_c1) < mean(tmp_c2)
    fore = 1;
else
    fore = 2;
end
clusters = zeros(size(Q));

if rback == 1
    clusters(idx == fore) = 1;
else
    len = length(idx_fore);
    ctmp = clusters;
    for p = 1:len
        ctmp(idx_fore(p)) = idx(p);
    end    
    clusters(ctmp == fore) = 1;
end

%output unprocessed mask
if no_posproc == 1
    R2 = img(:,:,1); G2 = img(:,:,2); B2 = img(:,:,3);
    R2(clusters == 0) = 0;
    G2(clusters == 0) = 0;
    B2(clusters == 0) = 0;
    image = cat(3,R2,G2,B2);
    
    return;
end


%clean small objects
se = strel('disk', 8);
clusters = imopen(clusters,se);
clusters = imclose(clusters,se);
mask = clusters;
% [labels mainL] = findMainObj(clusters,img_center);
% mask = zeros(size(labels));
% mask(labels == mainL) = 1;

mask = imfill(mask,'holes');

if ~isempty(niter) && niter > 0    
    if hull == 1
        mask2 = im2bw(mask);
        hull = bwconvhull(mask2);
        mask = double(hull);
    end
    
    mask_bkp = mask;
    
    try
        [gmag gdir] = imgradient(img(:,:,3));
        mask = region_seg(gscale(gmag),mask,niter,0.4,0);
        mask = imfill(mask,'holes');  
    catch
        fprintf('Error running snakes segmentation.\n');
        mask = mask_bkp;
    end
%[mask] = sfm_local_chanvese(gscale(gmag),new_mask,1000,0.2,10);
end

%mask image
R2 = img_bck(:,:,1); G2 = img_bck(:,:,2); B2 = img_bck(:,:,3);
R2(mask == 0) = 0;
G2(mask == 0) = 0;
B2(mask == 0) = 0;
image = cat(3,R2,G2,B2);

%clean white background details in histology
yiq = rgb2ntsc(image);
I = yiq(:,:,2);
I2 = gscale(I);
H = imhist(I2);

[max_H, idx_H] = max(H);
H(idx_H) = 0;

level = graythresh(I2);
thresh = 255*level;

if thresh < 1
    thresh = 127;
end

H2 = H;
H2(round(thresh):end) = 0;
x = 1: length(H);
[sigma, mu, norm_H] = gaussfit(x,H2); %fit a gaussian to the histogram

xp = 1:256;
yp = 1/(sqrt(2*pi)* sigma ) * exp( - (xp-mu).^2 / (2*sigma^2));
plot( x, norm_H, 'o', xp, yp, '-' );

%thresh0 = mu - 3*sigma;
thresh1 = mu + m_sigma * sigma;
%mask = ones(size(I2));
%mask(I2 <= floor(thresh0)) = 0;
mask(I2 >= round(thresh1)) = 0;


%remask image
R2 = image(:,:,1); G2 = image(:,:,2); B2 = image(:,:,3);
R2(mask == 0) = 0;
G2(mask == 0) = 0;
B2(mask == 0) = 0;
image = cat(3,R2,G2,B2);

end

%%%%%%
% Help functions
%%%%%%

%
% get information from mupT
%
function [mu covar] = getMupT(wsize,points,I,Q)

    [rows cols] = size(points);

    uI = [];
    uQ = [];
    for p = 1:rows
         mupT = points(p,:);
         ct = sub2ind(size(I),mupT(1), mupT(2));
         wI = getwindow(ct,I,wsize);
         wQ = getwindow(ct,Q,wsize);     
         uI = [uI; wI(:)];
         uQ = [uQ; wQ(:)];
    end    
     mu = [mean(uI(:)) mean(uQ(:))];
     cIQ = cat(2,uI,uQ);
     covar = cov(cIQ);
end

%
% get information from mupB
%
function [mu covar] = getMupB(wsize,points,I,Q)

    [rows cols] = size(points);

    uI = [];
    uQ = [];
    for p = 1:rows
         mupB = points(p,:);
         ct = sub2ind(size(I),mupB(1), mupB(2));
         wI = getwindow(ct,I,wsize);
         wQ = getwindow(ct,Q,wsize);     
         uI = [uI; wI(:)];
         uQ = [uQ; wQ(:)];
    end    
     mu = [mean(uI(:)) mean(uQ(:))];
     cIQ = cat(2,uI,uQ);
     covar = cov(cIQ);
end


%
% clean mask from small connected objects
%
function mask = clean(mask,p)

[labels nL] = bwlabel(mask);

%find largest
%maxL = 0;
maxCount = 0;
for l=1:nL
    nElem = length(find(labels == l));
    if nElem > maxCount
        maxCount = nElem;
        %maxL = l;
    end
end

for l=1:nL    
    nElem = length(find(labels == l));    
    if nElem <= maxCount*p % p% of the largest obj in the image
        labels(labels == l) = 0;
    end
end

mask(labels == 0) = 0;

end

%
% Find largest connected structure close to the image center
%

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