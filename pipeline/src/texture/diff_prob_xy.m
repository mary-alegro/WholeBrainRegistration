function [s] = diff_prob_xy(k,p)
%DIFF_PROB_XY
%
% P = DIFF_PROB_XY(K,P)
%
% INPUT:
% K index o wanted probability
%
% P normalized co-ocurrence matrix
%
% OUTPUT:
% S

[Ny,Nx] = size(p);
Ng = Ny;

if k > Ng - 1 || k < 0    
    error(sprintf('K must have a value between 0 and %d',(Ng-1)));
end

s = 0;

for i = 1:Ng
    for j = 1:Ng
        if abs(i-j) == k
            s = s + p(j,i);
        end
    end
end
