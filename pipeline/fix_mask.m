function mask = fix_mask(mask)

[rows cols N] = size(mask);
img_center = [round(rows/2) round(cols/2)];


%find connected structures
[labels nL] = bwlabel(mask);


mainL = 0;
minDist = 0;
for l = 1:nL
    [r,c] = find(labels == l);
    sizeObj = length(find(labels == l));
    centroid = [round(mean(r))  round(mean(c))];   
    
    dist = norm(img_center - centroid);
    if(mainL == 0) %must initialize variables
        minDist = dist;
        mainL = l;      
    end
       
    %get the largest object w/ min distance from center
    if(dist < minDist && sizeObj > 5000)
            minDist = dist;
            mainL = l;
    end 
end

mask = zeros(size(labels));
mask(labels == mainL) = 1;

mask = imfill(mask,'hole');

se = strel('disk', 4);
mask = imclose(mask, se);
mask = imfill(mask,'hole');