function [final_img T] = register(ref_img, mov_img)

%type wrapper.m;

[r c N] = size(ref_img);

roi =  [10 r-10 10 c-10];


ref_mask = ref_img;
ref_mask(ref_mask ~= 0) = 1;
[ref_labels nL] = bwlabel(ref_mask);
props = regionprops(ref_labels,'Centroid');
ref_centroid = [round(props.Centroid(2)) round(props.Centroid(1))];


mov_mask = mov_img;
mov_mask(mov_mask ~= 0) = 1;
[mov_labels nL] = bwlabel(mov_mask);
props = regionprops(mov_labels,'Centroid');
mov_centroid = [round(props.Centroid(2)) round(props.Centroid(1))];

shift = ref_centroid - mov_centroid;

mov_aux = zeros(r,c);
[idr idc] = find(mov_img ~= 0);
mov_aux(idr+shift(1), idc+shift(2)) = mov_img(idr,idc);


opt = optimset('Display','final');
T = fminsearch6555(@(x) wrapper(x,ref_img,mov_aux,@sav,roi),[1 1 0],[15 15 pi/32],opt);
%T_ct_search = fminsearch(@(x) wrapper(x,img1,img2,@joint_entropy,roi),[10 10 pi/16],opt)
%T_ct_search = fminunc(@(x) wrapper(x,img1,img2,@joint_entropy,roi),[10 10 pi/6],opt);

figure;
display_alignment(ref_img,image_transform(mov_aux,T)); axis off;
colormap gray;
title(['Reference Img + Moving Img, T = [' num2str(T) ' ]']);

final_img = image_transform(mov_aux,T);