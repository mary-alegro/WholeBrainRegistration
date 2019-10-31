function [final_img T] = pre_register_mops(ref_img,mov_img)
%
% Uses MOPS features to calculate a inital registration
% Used to avoid errors related to rotations and large translation
% difference between two images.
% Uses a modified version of MOPS mpicbg ImageJ plugin
%
% REF_IMG : reference image
% MOV_IMG: image to be registered
%

javaaddpath('/autofs/homes/005/malegro/bin/ImageJ/ij.jar')
javaaddpath('/autofs/homes/005/malegro/workspace/MatlabMOPS/Jama-1.0.2.jar')
javaaddpath('/autofs/homes/005/malegro/workspace/MatlabMOPS/bin')


ref = toJavaInteger(ref_img);
mov = toJavaInteger(mov_img);

%access Java plugin 
mops = mpicbg.MatlabMOPS();
mops.initMOPS(mov,ref);
mops.runMOPS();

%get transform
T = mops.getTransform();

tform = maketform('affine',[T(1) T(2) 0; T(3) T(4) 0; T(5) T(6) 1]);
final_img = imtransform(mov_img,tform,'XData',[1 size(mov_img,2)],'YData',[1 size(mov_img,1)]);

% figure,
% imshow(final_img);


end

