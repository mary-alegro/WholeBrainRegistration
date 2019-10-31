
%im = vl_impattern('roofs1') ;
im = imread('20.tif');

%figure(1) ; clf ;
%image(im) ; axis image off ;

im = adapthisteq(im);
im = anisodiff2D(im,40,1/7,3.5,2);

imgs = im2single(im) ;
%frames = vl_covdet(imgs, 'verbose') ;
frames = vl_covdet(imgs, 'method', 'MultiscaleHarris') ;
imshow(imgs,[]);
hold on ;
vl_plotframe(frames) ;

[fa, da] = vl_sift(imgs);
figure,
imshow(im,[]);
hold on,
vl_plotframe(fa) ;


