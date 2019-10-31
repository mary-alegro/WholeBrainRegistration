function M = calc_energy(img,ws)


[r c N] = size(img);
M = zeros(r,c);

nPixels = r*c;

for i=1:nPixels    
    w = getwindow(i,img, ws);
    [GS IS] = graycomatrix(w, 'NumLevels', 8, 'Offset',[0 1]);
    stats = graycoprops(GS,'Energy');
    M(i) = stats.Energy; 
end