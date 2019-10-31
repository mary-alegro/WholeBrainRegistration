function [features] = extracao_selecao_caracteristicas(pacientes,N)

% [FEATURES] = EXTRAI_SELECAO_CARACTERISTICAS(PACIENTES,N)
%
% Roda algoritmo que realiza selecao das caracteristicas mais relevantes
%
% PACIENTES : vetor com numero dos pacientes que devem ser considerados
% N : numero de caracteristicas que se quer
%

% modalidades
% t1 = 1
% t1c = 2;
% flair = 3;

dir_root = '/home/nex/LSI/Mestrado/implementacao/';

[labels,treino] = carrega_dados_textura(dir_root,pacientes); %carrega os dados dos arquivos

treino = rescale2(treino);

%discretiza matrix de dados em 3 estados
treino = discretiza(treino,1);

%seleciona caracteristicas
features = mrmr_mid_d(treino, labels, N);