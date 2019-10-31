function [final_img T] = register2(ref_img, mov_img)

%
% Same of register.m but consideres also the aligment between 
% the moving image and the reference image neighboors
%
% REF_IMG: a volume of images to be considered 
% MOV_IMG: the image to be registered
%

[r c N] = size(ref_img);

roi =  [10 r-10 10 c-10];

ref_mask = ref_img(:,:,1);
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

% weights for each neighboor 
%extra_params = ones(N,1);
extra_params = [1 0.25 0.10];

T = fminsearch6555(@(x) wrapper2(x,ref_img,mov_aux,@sav_3n,roi,extra_params),[1 1 0],[15 15 pi/32],opt);
%T_ct_search = fminsearch(@(x) wrapper(x,img1,img2,@joint_entropy,roi),[10 10 pi/16],opt)
%T_ct_search = fminunc(@(x) wrapper(x,img1,img2,@joint_entropy,roi),[10 10 pi/6],opt);

% figure;
% display_alignment(ref_img,image_transform(mov_img,T)); axis off;
% colormap gray;
% title(['Reference Img + Moving Img, T = [' num2str(T) ' ]']);

final_img = image_transform(mov_aux,T);