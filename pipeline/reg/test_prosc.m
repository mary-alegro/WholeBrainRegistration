function test_prosc

ref = imread('/autofs/homes/005/malegro/Registration/software/reg/21.tif');
mov = imread('/autofs/homes/005/malegro/Registration/software/reg/20_3.tif');

refs = anisodiff2D(ref,30,1/7,3,2);
movs = anisodiff2D(mov,30,1/7,3,2);
refe = edge(refs,'sobel');
move = edge(movs,'sobel');

refe = fixedge(refe);
move = fixedge(move);


[Rref, Cref] = find(refe == 1);
[Rmov, Cmov] = find(move == 1);
plot(Cref,Rref,'b.'); hold on,  plot(Cmov,Rmov,'r.'); hold off;


lenRef = length(Cref);
lenMov = length(Cmov);


if lenRef < lenMov
    Cmov = Cmov(1:lenRef);
    Rmov = Rmov(1:lenRef);
else
    Cref = Cref(1:lenMov);
    Rref = Rref(1:lenMov);
end


refV = cat(2,Rref,Cref);
movV = cat(2,Rmov,Cmov);

[d Z tr] = procrustes(refV,movV,'scaling',false);

m = det(tr.T);

if m < 0 %mirror
    
else
    ang = atan2(tr.T(1,2),tr.T(1,1));
end

 plot(refV(:,2),refV(:,1),'b.'); hold on,  plot(movV(:,2),movV(:,1),'r.');
 plot(Z(:,2),Z(:,1),'g.');
 
end

function mask2 = fixedge(mask)
 
 se = strel('disk', 5);
 %mask = imclose(mask, se);
 mask = imdilate(mask, se);
 %mask = imfill(mask,'hole');
 
 [labels nL] = bwlabel(mask);
 
mainL = 0;
lastSize = 0;
for l = 1:nL
    [r,c] = find(labels == l);
    sizeObj = length(find(labels == l));   
    
    if sizeObj > lastSize
        lastSize = sizeObj;
        mainL = l;
    end
end

mask2 = zeros(size(mask));
mask2(labels == mainL) = 1; 
 
end




