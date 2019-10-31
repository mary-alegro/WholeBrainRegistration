function matriz = mirror(matriz)

% [MATRIZ] = MIRROR(MATRIZ)
%
% Espelha a matriz 2D
%


matriz(:,end:-1:1) = matriz(:,:);

