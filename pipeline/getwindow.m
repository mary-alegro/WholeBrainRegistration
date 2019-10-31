function [w] = getwindow(center,m,ws)

%
% center = windows center
% m = image
% s = windows size
%

[rows cols N] =  size(m);
[rc cc] = ind2sub([rows cols], center);
s = floor(ws/2);

r1 = rc - s;
c1 = cc - s;

r2 = rc + s;
c2 = cc + s;

if (r1 < 1)
    r1 = 1;
end
if (c1 < 1)
    c1 = 1;
end
if (r2 > rows) 
    r2 = rows;
end
if(c2 > cols)
    c2 = cols;
end

  
w = m(r1:r2, c1:c2);    