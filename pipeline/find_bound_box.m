function [UL LR I] = find_bound_box(volume)

%
% Finds the bound box of a 3D volume
%

N = size(volume,3);

uls = zeros(N,2);
lrs = uls;
sides = zeros(N,2);

for s = 1:N
    %[corner width] = regionprops(volume(:,:,s),'BoundingBox');
    W = regionprops(im2bw(volume(:,:,s)),'BoundingBox');
    
    if length(W) > 1
        idx = findLBBox(W);
        W = W(idx);
    end
    
    uls(s,1) = round(W.BoundingBox(2)); %row = y
    uls(s,2) = round(W.BoundingBox(1)); %col = x  
    
    sides(s,1) =  W.BoundingBox(4);
    sides(s,2) =  W.BoundingBox(3);
    
    lrs(s,1) = round(W.BoundingBox(2) + W.BoundingBox(4)); %row = y
    lrs(s,2) = round(W.BoundingBox(1) + W.BoundingBox(3)); %col = x
end

%the larges rectange will be the one that fits all the slice ROIs
%get smaller upper left corner coordinates
min_col = min(uls(:,2));
[min_row] = min(uls(:,1));

%get largest rectangle sides
[max_col I] = max(lrs(:,2));
[max_row] = max(lrs(:,1));

UL = [min_row min_col];
LR = [max_row max_col];


end


function idx = findLBBox(W)

nW = length(W);

area = 0;
idx = 0;
for i=1:nW
    tmp = W(i).BoundingBox(3) * W(i).BoundingBox(4);
    if tmp > area
        area = tmp;
        idx = i;
    end
end

end
