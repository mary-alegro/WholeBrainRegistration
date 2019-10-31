function [stack masks] = preprocess_seg_roi(volume)

[rows cols N] = size(volume);

stack = zeros(rows,cols,N);
masks = stack;

for i=1:N
    close all;
    
    fprintf('Slice %d.\n',i);
    
    [new_img new_mask] = segImg(volume(:,:,i));
    stack(:,:,i) = new_img;
    masks(:,:,i) = new_mask;
end


end


function [img mask] = segImg(img)

nIter = 440;

orig = img;
img = gscale(img);

img = anisodiff2D(img,50,1/7,10,1);
img_sm = img;

img(orig == 0) = 0;
ed = edge(img,'sobel');
back = zeros(size(img));
back(img == 0) = 1;
se = strel('disk', 3);
back = imdilate(back,se);
ed(back == 1) = 0;
se = strel('disk', 10);
mask = imdilate(ed,se);
[mainL labels] = find_main_obj(mask);
mask(labels ~= mainL) = 0;
mask = imfill(mask,'hole');

%img2 = img;
%img2(mask == 0) = 0;

%w = fspecial('unsharp');
%img3 = imfilter(img2,w,'replicate');
%img3(img == 0) = 0;

% %refine mask
% ed = edge(img3,'sobel');
% back = zeros(size(img3));
% back(img3 == 0) = 1;
% 
% %img3 = anisodiff2D(img3,50,1/7,10,1);
% 
% se = strel('disk', 3);
% back = imdilate(back,se);
% ed(back == 1) = 0;
% se = strel('disk', 5);
% %mask = imclose(ed,se);
% mask = imdilate(ed,se);
% mask = imfill(mask,'hole');
% 
% 
% img4 = orig;
% img4(mask == 0) = 0;
% 
% img = img4;
% 
% imshow(orig,[]);
% hold on, contour(img,[0 0],'g','linewidth',1); 

%test levelsets

img_sm = tofloat(img_sm);
w8 = [ 1 1 1 ; 1 -8 1 ; 1 1 1 ];
img_fl = imfilter(img_sm,w8,'replicate');
img_sm2 = img_sm-img_fl;

mask2 = ones(size(img));
mask2(orig == 0) = 0;
mask2(mask == 1) = 0;

ok = true;
while(ok)             
    mask3 = region_seg(gscale(img_sm2),mask2,nIter);
    
    img = orig;
    img(mask3 == 1) = 0;
    
    close all;
    imshow(orig,[]);
    hold on, contour(img,[0 0],'g','linewidth',1);
    
    novo_nIter = input('New iteration number? ');            
    if isempty(novo_nIter) || novo_nIter <= 0
        ok = false;
        close;
    end
    nIter = novo_nIter;
end

img = orig;
img(mask3 == 1) = 0;

mask = mask3;

% close all;
% imshow(orig,[]);
% hold on, contour(img,[0 0],'g','linewidth',1);

end