function [final_img] = histo_seg_foreground_kmeans(image)

% proprocessing of histology plates

%img = imread(file);
img = imresize(image,0.25);
img = im2double(img);

[rows cols N] = size(img);

img_gry = rgb2gray(img);

%image center (all interesting material will be near the center)
img_center = [round(rows/2) round(cols/2)];

HSI = rgb2hsi(img);
H = HSI(:,:,1); S = HSI(:,:,2); I = HSI(:,:,3);

img_blur = anisodiff2D(img_gry,25,1/7,10,1);

%features = cat(2,H(:),S(:),I(:),img_blur(:));
features = cat(2,H(:),S(:),I(:),img_blur(:));

subplot(3,2,1);
imshow(img);

%cluster analisys 
[idx,ctrs] = kmeans(features,2,'Distance','cityblock','Replicates',5);

%figure,plot3(H(idx==1),S(idx==1),I(idx==1),'b.'); hold on,
%plot3(H(idx==2),S(idx==2),I(idx==2),'r.');
%plot3(ctrs(1,1),ctrs(1,2),ctrs(1,3),'k*');
%plot3(ctrs(2,1),ctrs(2,2),ctrs(2,3),'ko');
%xlabel('Hue'); ylabel('Saturation'); zlabel('Brightness'); 

%find the center who represents foreground (lowest light)
[m fore] = min(ctrs(:,3));
 
clusters = zeros(size(H));
%clusters(idx == 1) = 1;
%clusters(idx == 2) = 0;

clusters(idx == fore) = 1;
clusters(idx ~= fore) = 0;

subplot(3,2,2);
imshow(clusters);

se = strel('disk', 2);
img2 = imopen(clusters, se);

%find connected structures
[labels nL] = bwlabel(img2);

%imshow(img2); 
%hold on,

%find structure whose centroirandonly pick indices matlabd is nearest to the image center
%plot(img_center(2),img_center(1),'Marker','o','MarkerSize',10,'MarkerEdgeColor','r')

l = 1;
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
    if(dist < minDist && sizeObj > 5000)
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

subplot(3,2,3);
imshow(mask);


%segment
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

R(mask == 0) = 0;
G(mask == 0) = 0;
B(mask == 0) = 0;

final_img = cat(3,R,G,B);

subplot(3,2,4);
imshow(final_img);


subplot(3,2,5);
imshow(img_blur);






