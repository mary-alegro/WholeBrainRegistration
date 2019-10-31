
Ia = imread('/autofs/space/hercules_001/users/malegro/HISTOPATO/CasosCIN/CIN038/seg/CIN 038 BL2 LAM1_0035.tif');
Ib = imread('/autofs/space/hercules_001/users/malegro/HISTOPATO/CasosCIN/CIN038/seg/CIN 038 BL2 LAM1_0036.tif');

%Ia = imread('20_3.tif');
%Ib = imread('21.tif');

Ia = rgb2gray(Ia);
Ib = rgb2gray(Ib);

% background masks
maska = Ia;
maska(maska ~= 0) = 1;
maskb = Ib;
maskb(maskb ~= 0) = 1;

Ia = adapthisteq(Ia);
Ib = adapthisteq(Ib);

%Ia = anisodiff2D(Ia,40,1/7,3.5,2);
%Ib = anisodiff2D(Ib,40,1/7,3.5,2);

Ia = single(Ia);
Ib = single(Ib);

%compute sift 
[fa, da] = vl_sift(Ia);
[fb, db] = vl_sift(Ib);

%remove points outside the ROI
aux_a = ones(size(fa,2),1);
aux_b = ones(size(fb,2),1);

for p = 1:size(fa,2)    
    if maska(round(fa(2,p)),round(fa(1,p))) == 0
        aux_a(p) = 0;
    end
end
fa = fa(:,find(aux_a == 1));
da = da(:,find(aux_a == 1));

for p = 1:size(fb,2)    
    if maskb(round(fb(2,p)),round(fb(1,p))) == 0
        aux_b(p) = 0;
    end
end
fb = fb(:,find(aux_b == 1));
db = db(:,find(aux_b == 1));


%compute matches
[matches, scores] = vl_ubcmatch(da, db, 1.5);

[drop, perm] = sort(scores, 'descend') ;
matches = matches(:, perm) ;
scores  = scores(perm) ;

%
% RANSAC
%
ran = ransac(fa,fb,matches);
matches = matches(:,ran);


%
% remove duplicated edges based on distance between pairs
%

rep = ones(size(matches));

%remove repetitions in a
dups = duplicates(matches(1,:));
if ~isempty(dups)    
    for v = dups
        idx = find(matches(1,:) == v);
        rep(1,idx) = 0;
        minDist = min(scores(idx));       
        idxMinDist = find(scores == minDist);
        rep(1,idxMinDist) = 1;
    end
end

%remove repetitions in b
dups = duplicates(matches(2,:));
if ~isempty(dups)    
    for v = dups
        idx = find(matches(2,:) == v);
        rep(2,idx) = 0;        
        minDist = min(scores(idx));       
        idxMinDist = find(scores == minDist);
        rep(2,idxMinDist) = 1;
    end
end

%use only non duplicated pairs
pairs = find(rep(1,:) & rep(2,:));
matches2 = matches(:,pairs);
scores2 = scores(pairs);

%
% ransac to remove ouliers
%

%ran = ransac(fa,fb,matches2);
%matches2 = matches2(:,ran);


% %
% % filter by line angular coef
% %
% 
% xa = fa(1,matches2(1,:)) ;
% xb = fb(1,matches2(2,:)) ;
% ya = fa(2,matches2(1,:)) ;
% yb = fb(2,matches2(2,:)) ;
% 
% %mean
% M = (yb - ya)./(xb - xa);
% me = mean(M);
% st = std(M);
% coefs = M((M < me+st) & (M > me-st));
% 
% xa = fa(1,matches2(1,:)) ;
% xb = fb(1,matches2(2,:)) + size(Ia,2) ;
% ya = fa(2,matches2(1,:)) ;
% yb = fb(2,matches2(2,:)) ;
% 
% figure,
% imshow(cat(2, Ia, Ib),[]); 
% hold on,
% for c = coefs
%     l = find(M == c);
%     h = line([xa(l); xb(l)], [ya(l) ; yb(l)]) ;
%     set(h,'linewidth', 1, 'color', 'b') ;   
% end
% 
% vl_plotframe(fa(:,matches2(1,:))) ;
% fb(1,:) = fb(1,:) + size(Ia,2);
% vl_plotframe(fb(:,matches2(2,:))) ;
% %axis image off ;


%show pairs
figure,
imshow(cat(2, Ia, Ib),[]); 

xa = fa(1,matches2(1,:)) ;
xb = fb(1,matches2(2,:)) + size(Ia,2) ;
ya = fa(2,matches2(1,:)) ;
yb = fb(2,matches2(2,:)) ;


hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fa(:,matches2(1,:))) ;
fb(1,:) = fb(1,:) + size(Ia,2);
vl_plotframe(fb(:,matches2(2,:))) ;
axis image off ;
hold off;

TRI = delaunay([xa; xb], [ya; yb]);




