function [marcas] = treina_normaliza_mri(params, treino, L)

%
% [marcas] = treina_normaliza_mri(params, volume, tipo)
%
% Calcula vetor de marcas (landmarks) a partir do volume de treino
%

s1 = params(1);
s2 = params(2);


treino = double(treino);


marcas = calcula_marcas_normalizacao(params,treino,L); % calcula intensidade media das marcas, a partir de imagens de "treino"
marcas = [s1 marcas s2];