function [vetor_discreto] = discretiza(vetor,alpha)

% [VETOR_DISCRETO] = DISCRETIZA(VETOR,ALPHA)
%
% Discretiza variaveis continuas em 3 estados (-2 0 2)
% Calculo: media +/- alpha*desvio_padrao 
% (Para uso com algoritmo RMRM)
%
% VETOR : dados que devem ser discretizados. Pode ser uma matriz MxN ou um vetor. 
% 
% ALPHA : fator de "ampliacao" da classe do meio
% ALPHA = (0,0.5,1,2)


if (alpha ~= 0 && alpha ~= 0.5 && alpha ~= 1 && alpha ~= 2)
    error('Alpha deve ter valores 0, 0.5, 1 ou 2');
end

mu = mean(vetor);
o = std(vetor);
o_mais = mu+o*alpha;
o_menos = mu-o*alpha;

vetor_discreto = zeros(size(vetor));
tmp1 = vetor_discreto + 1;
tmp2 = tmp1;

cols = size(vetor,2);

for i=1:cols
    tmp1(:,i) = tmp1(:,i)*o_mais(i);
    tmp2(:,i) = tmp2(:,i)*o_menos(i);
end

vetor_discreto(vetor > tmp1) = 2;
vetor_discreto (vetor < tmp2) = -2;


