
function [pij] = normalize_ccm(P,dir,dist)
%NORMALIZE_CCM normalizes co-occurrence matrix according to direction and
%distance used [p(i,j)].
%
% PIJ = NORMALIZE_CCM(P,DIR,DIST)
%
% INPUT:
% P co-occurrence matrix        
%
% DIR: direction of evaluation
%       "dir" value                    Angle
%           0                            0
%           1                           45
%           2                           90
%           3                           135
%
% DIST: distance between pixels
%
%
% OUTPUT:
% PIJ normalized co-occurrence matrix
%

d = dist; %TODO verify this!!!
[Ny,Nx] = size(P);
R = 1;

switch dir
    case 0
        R = 2*Ny*(Nx-d);    
    case 1
        R = 2*(Ny-d)*(Nx-d);
    case 2
        R = 2*Nx*(Ny-d);
    case 3
        R = 2*(Nx-d)*(Ny-d);
end

pij = P./R;

%----------------------------------------------%

function [pxi] = marginal_prob_x(i,p)
%MARGINAL_PROB_X gives the ith marginal probability
%
% PXI = MARGINAL_PROB_X(I,P)
%
% INPUT:
% I index o wanted probability
%
% P normalizes co-ocurrence matrix
%
% OUTPUT:
% PXI ith probability 

%[Ny,Nx] = size(pij);

pxi = sum(p(:,i));

%----------------------------------------------%

function [pyj] = marginal_prob_y(j,p)
%MARGINAL_PROB_Y gives the ith marginal probability
%
% PYJ = MARGINAL_PROB_X(J,P)
%
% INPUT:
% J index o wanted probability
%
% P normalized co-ocurrence matrix
%
% OUTPUT:
% PYJ ith probability 

pyj = sum(p(j,:));

%----------------------------------------------%

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

[Ny,Nx] = size(pij);
Ng = Ny;

if k > 2*Ng || k < 2    
    error(sprintf('K must have a value between 2 and %d',Ng));
end


for i = 1:Ng
    for j = 1:Ng
        if i+j == k
            s = s + p(j,i);
        end
    end
end

%----------------------------------------------%

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

[Ny,Nx] = size(pij);
Ng = Ny;

if k > Ng-1 || k < 0    
    error(sprintf('K must have a value between 0 and %d',(Ng-1)));
end


for i = 1:Ng
    for j = 1:Ng
        if abs(i-j) == k
            s = s + p(j,i);
        end
    end
end

%----------------------------------------------%



    
   