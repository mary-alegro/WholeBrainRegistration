function matriz = shuffle_matrix(matriz)

%
% MATRIZ = SHUFFLE_MATRIX(MATRIZ)
%
% Embaralha as linhas de uma matriz
%
% MATRIZ : Matriz que se quer embaralhar
%

[r c N] = size(matriz);

meio = floor(r/2);

for i=1:meio
    if(mod(i,2) ~= 0) %se for impar
        tmp = matriz(i,:);
        matriz(i,:) = matriz(r-i+1,:);
        matriz(r-i+1,:) = tmp(1,:);
    end
end