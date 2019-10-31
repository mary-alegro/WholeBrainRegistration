function final_img = straighten(img)

[r c N] = size(img);
max_D = max([r c]);
new_max = max_D + 100; %increase size to avoid images falling out of frame
final_img = zeros(new_max,new_max);
center_max = [floor(new_max/2) floor(new_max/2)];

[ref_labels ref_nL] = bwlabel(img);
props = regionprops(ref_labels,'Orientation');


%if(props.Orientation < 0)
%    img = imrotate(img,-(90+props.Orientation),'bilinear');
%else
%    img = imrotate(img,90-props.Orientation,'bilinear');
%end

[imr imc imN] = size(img);
aux = zeros(imr+20,imc+20);
aux(11:imr+10, 11:imc+10) = img(:,:);
img = aux;


[ref_labels ref_nL] = bwlabel(img);
props = regionprops(ref_labels,'BoundingBox');

bbox = round([props.BoundingBox(2) props.BoundingBox(1) props.BoundingBox(4) props.BoundingBox(3)]);

p = [center_max(1)-floor(bbox(3)/2) center_max(2)-floor(bbox(4)/2)];


final_img(p(1):p(1)+bbox(3), p(2):p(2)+bbox(4)) = ...
    img(bbox(1):bbox(1)+bbox(3), bbox(2):bbox(2)+bbox(4));












