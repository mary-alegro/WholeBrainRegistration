function test_mops_java


javaaddpath('/autofs/homes/005/malegro/bin/ImageJ/ij.jar')
javaaddpath('/autofs/homes/005/malegro/workspace/MatlabMOPS/Jama-1.0.2.jar')
javaaddpath('/autofs/homes/005/malegro/workspace/MatlabMOPS/bin')

img1 = imread('21.tif');
img2 = imread('20_3.tif');

img1 = adapthisteq(img1);
img2 = adapthisteq(img2);

[rows cols] = size(img1);




image1 = javaArray('java.lang.Integer',rows, cols);
for r=1:rows
    for c=1:cols
        image1(r,c) = java.lang.Integer(img1(r,c));
    end
end


image2 = javaArray('java.lang.Integer',rows, cols);
for r=1:rows
    for c=1:cols
        image2(r,c) = java.lang.Integer(img2(r,c));
    end
end

mops = mpicbg.MatlabMOPS();
mops.initMOPS(image1,image2);
mops.runMOPS();
ref_pointsL = mops.getRefLCoords();
ref_pointsL = ref_pointsL - 1.0;
mov_pointsL = mops.getMovLCoords();
mov_pointsL = mov_pointsL - 1.0;

T = mops.getTransform();

[rows cols] = size(ref_pointsL);

% figure,
% imshow(img1); hold on,
% for i=1:cols
%     plot(ref_pointsL(1,i),ref_pointsL(2,i),'Marker','*','MarkerSize',10,'MarkerEdgeColor','r')
% end
% hold off;
% 
% figure,
% imshow(img2); hold on,
% for i=1:cols
%     plot(mov_pointsL(1,i),mov_pointsL(2,i),'Marker','*','MarkerSize',10,'MarkerEdgeColor','r')
% end
% hold off;

tform = maketform('affine',[T(1) T(2) 0; T(3) T(4) 0; T(5) T(6) 1]);
img3 = imtransform(img1,tform,'XData',[1 size(img1,2)],'YData',[1 size(img1,1)]);

figure,
imshow(img3);
