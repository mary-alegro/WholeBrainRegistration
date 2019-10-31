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

