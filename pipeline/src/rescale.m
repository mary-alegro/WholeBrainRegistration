function [scaled] = rescale(Data, Lower, Upper,dim)

% [scaled] = rescale(Data);
% [scaled] = rescale(Data, Lower, Upper,Dim);
%
% scale the elements of all the column vectors in
% the range of [Lower Upper]. (default [-1 1])
%
% Dim : 1 (linhas) 2 (colunas) 3 (toda a matriz) ou  4 (todo o volume)}

if (nargin<3)
   Lower = -1;
   Upper = 1;
elseif (Lower > Upper)
   disp ('Wrong Lower or Upper values!');
end

if dim > 4 || dim < 1
    error('Dim deve ser 1, 2, 3 ou 4');
end

if dim == 4    %volume 3D
    minD = min(Data(:));
    maxD = max(Data(:));
    scaled = (Upper - Lower)/(maxD - minD) * (Data - minD) + Lower;
elseif dim == 3   %fatia 2D
    [r c N] = size(Data);
    for j = 1:N
        matriz = Data(:,:,j);
        matriz = lineariza(matriz,Upper,Lower);
        Data(:,:,j) = matriz(:,:);            
    end        
elseif dim == 2     %coluna
    [r c N] = size(Data);
    for n = 1:N
        for j = 1:c
            vetor = Data(:,c,n);
            vetor = lineariza(vetor,Upper,Lower);
            Data(:,c,n) = vetor(:);    
        end
    end
elseif dim == 1 %linha
    [r c N] = size(Data);
    for n = 1:N
        for j = 1:r
            vetor = Data(r,:,n);
            vetor = lineariza(vetor,Upper,Lower);
            Data(r,:,n) = vetor(:);    
        end
    end    
end

scaled = Data;

end

            
function matriz = lineariza(vetor,U,L)    
    minD = min(vetor(:));
    maxD = max(vetor(:));
    matriz = (U - L)/(maxD - minD) * (vetor - minD) + L;    
end