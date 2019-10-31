function [s] = sum_prob_xy(k,p)
%SUM_PROB_XY
%
% S = SUM_PROB_XY(K,P)
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

if k > 2*Ng || k < 2    
    error(sprintf('K must have a value between 2 and %d',Ng));
end

s = 0;

for i = 1:Ng
    for j = 1:Ng
        if i+j == k
            s = s + p(j,i);
        end
    end
end
