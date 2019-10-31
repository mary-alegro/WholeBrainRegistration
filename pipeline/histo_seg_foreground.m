function [image mask final_img] = histo_seg_foreground(image)

% proprocessing of histology plates

image = imresize(image,0.25);
img = rgb2gray(image);

subplot(3,2,1);
imshow(image);

[rows cols N] = size(img);
img_center = [round(rows/2) round(cols/2)];

comp = compress_hist(img);
img3 = anisodiff2D(comp,30,1/7,10,1);
ff = edge(img3,'canny');

subplot(3,2,2);
imshow(img3,[]);

se = strel('disk',5);
img2 = imclose(ff,se);

img2 = imfill(img2,'holes');


subplot(3,2,3);
imshow(img2);


%find connected structures
[labels nL] = bwlabel(img2);

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

mask = zeros(size(labels));
mask(labels == mainL) = 1;

mask = imfill(mask,'hole');

se = strel('disk', 4);
mask = imclose(mask, se);
mask = imfill(mask,'hole');

subplot(3,2,4);
imshow(mask);


%segment
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

R(mask == 0) = 0;
G(mask == 0) = 0;
B(mask == 0) = 0;

final_img = cat(3,R,G,B);

subplot(3,2,5);
imshow(image);
hold on, contour(mask,[0 0],'g','linewidth',2);







