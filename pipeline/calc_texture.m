function features = calc_texture(img, ws)

[r c N] = size(img);
nPixels = r*c;
features = zeros(nPixels,4);

for i=1:nPixels    
    w = getwindow(i,img, ws);
    [GS IS] = graycomatrix(w, 'NumLevels', 8, 'Offset',[0 1]);
    stats = graycoprops(GS,'All');
    
    features(i,1) = stats.Contrast; 
    features(i,2) = stats.Correlation; 
    features(i,3) = stats.Energy; 
    features(i,4) = stats.Homogeneity; 
end