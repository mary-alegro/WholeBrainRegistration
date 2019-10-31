function new_img = preprocess_init_affine(img_ref,img_mov)

%
% Creates a gross initial alignment through centralization, rotation and
% scaling
%
% IMG_REF: reference (fixed) image, grayscale. I.e. Blockface
% IMG_MOV: movable image, grayscale. Ie. Histology
%

mask_ref = zeros(size(img_ref));
mask_mov = zeros(size(img_mov));
mask_ref(img_ref > 10) = 1;
mask_mov(img_mov > 10) = 1;

%clean small connected structures
se = strel('disk', 3);
mask_ref = imopen(mask_ref,se);
%mask_ref = imclose(mask_ref,se);

mask_mov = imopen(mask_mov,se);
%mask_mov = imclose(mask_mov,se);



ref_hull = bwconvhull(mask_ref);
mov_hull = bwconvhull(mask_mov);

ref_p = regionprops(ref_hull,'Centroid','MajorAxisLength','MinorAxisLength','BoundingBox');
mov_p = regionprops(mov_hull,'Centroid','MajorAxisLength','MinorAxisLength','BoundingBox');

rate = ref_p.MajorAxisLength/mov_p.MajorAxisLength;

mov2 = imresize(img_mov,rate);
mov2_hull = bwconvhull(mov2);
mov2_p = regionprops(mov2_hull,'Centroid','BoundingBox');

new_img = uint8(zeros(size(img_ref)));

rbb = ref_p.BoundingBox;
mbb = mov2_p.BoundingBox;

new_img(rbb(2):rbb(2)+mbb(4),rbb(1):rbb(1)+mbb(3)) = ...
    mov2(mbb(2):mbb(2)+mbb(4),mbb(1):mbb(1)+mbb(3));








