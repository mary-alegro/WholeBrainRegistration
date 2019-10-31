function [mainL labels] = find_main_obj(img)
%
% Find the largest connected component of IMG
% IMG : BW image
% MAINL : largest object's label number (from bwlabel function)
% LABELS : label map from bwlabel

%find connected structures
[labels nL] = bwlabel(img);

mainL = 0;
sizeObj = 0;
for l = 1:nL    
    len = length(find(labels == l));    
    
    if(len > sizeObj)
        sizeObj = len;
        mainL = l;
    end 
end


end

