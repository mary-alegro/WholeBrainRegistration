function num = uniformrandint(m,n)

% NUM = UNIFORMRANDINT(M,N)
%
% Retorna um valor aleatorio uniformemente espacado dentro do intervalo [M,N]
%
% [M,N] : intevalo dos inteiros a ser escolhidos

num = ceil((n-m+1)*rand+m-1);