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
