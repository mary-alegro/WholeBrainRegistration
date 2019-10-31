function image = seg_blockface(img)

%img = rgb2gray(img);
img = imresize(img,0.15);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
R_B = R-B;

[rows cols] = size(R_B);
img_center = [round(rows/2) round(cols/2)];

level = graythresh(R_B);
mask = im2bw(R_B,level);

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

mask = zeros(rows,cols);
mask(labels == mainL) = 1;
mask = imfill(mask,'holes');

% R = img(:,:,1); G = img(:,:,2); B = img(:,:,3);
% R(mask == 0) = 0; 
% G(mask == 0) = 0;
% B(mask == 0) = 0;
% img2 = cat(3,R,G,B);

%[L A B] = RGB2Lab(img);
%B2 = imadjust(gscale(B));
%G2 = imadjust(G);

%R_B = adapthisteq(R_B);
R_B = imadjust(R_B);
R_B2 = anisodiff2D(R_B,30,1/7,10,1);
mask = region_seg(gscale(R_B2),mask,600,0.2,1);
%[mask] = sfm_local_chanvese(gscale(R_B2),mask,1000,0.2,10);


% [H S V] = rgb2hsv(img);
% 
% level = graythresh(H);
% mask = im2bw(H,level);
% 
% R = img(:,:,1); G = img(:,:,2); B = img(:,:,3);
% R(mask == 1) = 0; 
% G(mask == 1) = 0;
% B(mask == 1) = 0;
% 
% img2 = cat(3,R,G,B);
% [L A B] = RGB2Lab(img2);
% %image = imadjust(gscale(B),[92/255 150/255], [], 1);
% 
% mask = gscale(B);
% mask(mask < 20) = 0;
% mask(mask ~= 0) = 1;
% 
% %B2 = imadjust(gscale(B),[82/255 150/255], [], 1);
% B2 = imadjust(gscale(B));
% 
% %mask = region_seg(B2,mask,600);
% mask = region_seg(B2,mask,600,0.2,0);
% %[mask] = sfm_local_chanvese(B2,mask,1000,0.2,10);
% 
% %clean small objs
% mask = clean(mask,0.006);
% 
% %close holes
% mask = imfill(mask,'holes');
% 
% % R = img(:,:,1); G = img(:,:,2); B = img(:,:,3);
% % R(mask == 0) = 0; 
% % G(mask == 0) = 0;
% % B(mask == 0) = 0;
% % image = cat(3,R,G,B);
% 
% image = rgb2gray(img);
% image(mask == 0) = 0;


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