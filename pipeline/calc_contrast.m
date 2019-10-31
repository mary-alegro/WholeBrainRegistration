function M = calc_contrast(img,ws)


[r c N] = size(img);
M = zeros(r,c);

nPixels = r*c;

for i=1:nPixels    
    w = getwindow(i,img, ws);
    [GS IS] = graycomatrix(w, 'NumLevels', 8, 'Offset',[0 1]);
    stats = graycoprops(GS,'Contrast');
    M(i) = stats.Correlation; 
end
