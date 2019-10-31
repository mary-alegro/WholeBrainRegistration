function clusters = color_seg(img)

R = img(:,:,1);
fore = zeros(size(R));
fore(R ~= 0) = 1;

HSI = rgb2hsi(img);
H = HSI(:,:,1); S = HSI(:,:,2); I = HSI(:,:,3);

index = find(fore == 1);

features = cat(2, H(index), S(index), I(index));

[idx,ctrs] = kmeans(features,2,'Distance','cityblock','Replicates',10);

[m fore] = min(ctrs(:,3));


clusters = zeros(size(R));
clusters(index(idx == fore)) = 1;
clusters(index(idx ~= fore)) = 0;
%clusters(index(idx == 1)) = 1;
%clusters(index(idx == 0)) = 0;

se = strel('disk',3);
clusters = imdilate(clusters,se);

