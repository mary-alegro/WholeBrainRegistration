function test_blockface(img)

%img = rgb2gray(img);
img = imresize(img,0.10);

[H S V] = rgb2hsv(img);

level = graythresh(H);
mask = im2bw(H,level);

R = img(:,:,1); G = img(:,:,2); B = img(:,:,3);
R(mask == 1) = 0; 
G(mask == 1) = 0;
B(mask == 1) = 0;

img2 = cat(3,R,G,B);
[L A B] = RGB2Lab(img2);
%image = imadjust(gscale(B),[92/255 150/255], [], 1);

mask = gscale(B);
mask(mask < 20) = 0;
mask(mask ~= 0) = 1;

%B2 = imadjust(gscale(B),[82/255 150/255], [], 1);
B2 = imadjust(gscale(B));

region_seg(B2,mask,600);

image2 = edge(image,'canny');
se = strel('disk', 4);
image3 = imdilate(image2,se);

%find connected structures
[labels nL] = bwlabel(image3);


mainL = 0;
maxSize = 0;
for l = 1:nL
    [r,c] = find(labels == l);
    sizeObj = length(find(labels == l)); 
    
    if sizeObj > maxSize
        maxSize = sizeObj;
        mainL = l;
    end

end

mask = zeros(size(labels));
mask(labels == mainL) = 1;

mask = imfill(mask,'hole');

se = strel('disk', 4);
mask = imclose(mask, se);
mask = imfill(mask,'hole');