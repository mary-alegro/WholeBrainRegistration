function f = wrapper2(params,im1,im2,obj_f,roi)

%
% im1: reference image(s)
% im2: moving image
%

A = 1;

[r c N] = size(im1);
if(N == 1) %only 1 image considered
 
   if isempty(roi), roi = [1 size(im1,2) 1 size(im2,1)]; end
   
   roiX   = roi(1):roi(2);
   roiY   = roi(3):roi(4);
   
   im2t = image_transform(im2,params);
   
   f = obj_f(im1(roiY,roiX),im2t(roiY,roiX));
   
else %multiple neighboors considered
    
   %all images should be the same size 
   if isempty(roi), roi = [1 size(im1(:,:,1),2) 1 size(im2,1)]; end
   
   roiX   = roi(1):roi(2);
   roiY   = roi(3):roi(4);
   
   
   im2t = image_transform(im2,params);
   
   %
   % image order inside the volume is importate here
   % the first image will be considered the most importante
   % the other images will be considered as occording to weight A
   % weight A 
   %
   im = im1(:,:,1);
   f = obj_f(im(roiY,roiX),im2t(roiY,roiX));
   
   f2 = 0;
   for t=2:N
        im = im1(:,:,t);   
        f2 = f2 + obj_f(im(roiY,roiX),im2t(roiY,roiX));
   end
   
   f = f + A*f2;
   
    
end

   
   %if 1
   if 0
     figure(1);
     display_alignment(im1,im2t); hold on;
     plot([roi(1) roi(1) roi(2) roi(2) roi(1)],[roi(3) roi(4) roi(4) roi(3) roi(3)],'r-');
     hold off;
     drawnow;
   end
