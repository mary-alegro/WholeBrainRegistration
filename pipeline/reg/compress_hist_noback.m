function [image] = compress_hist_noback(img)

thresh = 100;
img = gscale(img);
[H bins] = imhist(img);
H(1) = 0;
i_maxH = find(H == max(H));
i_maxH = i_maxH(end);

nBins = length(bins);

lH = H(1:i_maxH);
rH = H(i_maxH+1:end);

%find cut point in lH

minLH = min(lH(lH > thresh));
i_minLH = find(lH == minLH);
i_minLH = i_minLH(end);

i_lCP = i_minLH;

%find cut point in rH
if ~isempty(rH)
    minRH = min(rH(rH > thresh));
    i_minRH = find(rH == minRH);
    i_minRH = i_minRH(1); %closest to the middle of H

    i_rCP = i_maxH + i_minRH + 1;
    if(i_rCP >= nBins)
        i_rCP = nBins - 1;
    end
else
    i_rCP = nBins - 1;
end

v_lCP = i_lCP * (1/nBins);
v_rCP = i_rCP * (1/nBins);

image = imadjust(img,[v_lCP v_rCP], [], 1);