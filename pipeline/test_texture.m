function test_texture(img)

ws = 9;

[r c N] = size(img);
txt1 = zeros(r,c);
txt2 = zeros(r,c);
txt3 = zeros(r,c);
txt4 = zeros(r,c);


nPixels = r*c;

for i=1:nPixels    
    w = getwindow(i,img, ws);
    [GS IS] = graycomatrix(w, 'NumLevels', 8, 'Offset',[0 1]);
    stats = graycoprops(GS,'All');
    
    txt1(i) = stats.Contrast;
    txt2(i) = stats.Energy;
    txt3(i) = stats.Correlation;
    txt4(i) = stats.Homogeneity;
 
end

subplot(2,2,1);
imshow(gscale(txt1));
subplot(2,2,2);
imshow(gscale(txt2));
subplot(2,2,3);
imshow(gscale(txt3));
subplot(2,2,4);
imshow(gscale(txt4));




