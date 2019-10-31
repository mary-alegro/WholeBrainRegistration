function [img2] = threshold(img,L)

% [IMG2] = THRESHOLD(IMG,L)
%
% Limiariza imagem
%

iMin = min(img(:));
iMax = max(img(:));

if L < iMin && L > iMax
    error('valor de L fora do intervalo aceito')
end

img2 = zeros(size(img));
img2(img >= L) = 1;