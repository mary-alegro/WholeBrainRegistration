function test_rot


ref = imread('/autofs/homes/005/malegro/Registration/software/reg/21.tif');
mov = imread('/autofs/homes/005/malegro/Registration/software/reg/11.tif');
mov_bkp = mov;

ref = centralize(ref);
mov = centralize(mov);

nRot = 80;
ang = 360/nRot;

error = zeros(nRot,1);
angs = error;
iAng = 0;

    for i = 1:nRot
        mov = imrotate(mov,ang,'crop');
        error(i) = ssd(ref,mov);
        iAng = iAng+ang;
        angs(i) = iAng;
        
    end

    plot(error); 
    
    m = find(error == min(error));
    fang = angs(m);
    
    final = imrotate(mov_bkp,fang,'bicubic','crop');
    imshow(final,[]);

end




function final_img = centralize(img)

[r c N] = size(img);
max_D = max([r c]);
final_img = zeros(max_D,max_D);
center_max = [floor(max_D/2) floor(max_D/2)];


[ref_labels ref_nL] = bwlabel(img);
props = regionprops(ref_labels,'BoundingBox');

bbox = round([props.BoundingBox(2) props.BoundingBox(1) props.BoundingBox(4) props.BoundingBox(3)]);

p = [center_max(1)-floor(bbox(3)/2) center_max(2)-floor(bbox(4)/2)];

final_img(p(1):p(1)+bbox(3), p(2):p(2)+bbox(4)) = ...
    img(bbox(1):bbox(1)+bbox(3), bbox(2):bbox(2)+bbox(4));

end


function s = ssd(img1,img2)

SD = (img1-img2).^2;
s = sum(SD(:));

end