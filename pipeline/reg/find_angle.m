function find_angle(img1, img2)


img1 = im2double(img1);
[dx,dy] = gradient(img1);
ang1 = atan2(dy,dx);
edges1 = edge(ang1,'canny');
bw1 = bwmorph(edges1,'dilate');
mask1 = ang1.*bw1;
%subplot(2,1,1);hist(im11111);
hist1 = hist(mask1(:),256);
fft1 = fft(hist1);


img2 = im2double(img2);
[dx,dy] = gradient(img2);
ang2 = atan2(dy,dx);
edges2 = edge(ang2,'canny');
bw2 = bwmorph(edges2,'dilate');
mask2 = ang2.*bw2;
%subplot(2,1,2);hist(im22222);
hist2 = hist(mask2(:),256);
conj2 = conj(fft(hist2));

angles = real(ifft(fft1.*conj2));
angles(1) = 0;
plot(angles);
[y,x]=max(angles);
rel_deg=((x*(2*pi/256))*180)/pi;

if rel_deg>180;
    new_rel_deg=rel_deg-180
else
    new_rel_deg=rel_deg
end



