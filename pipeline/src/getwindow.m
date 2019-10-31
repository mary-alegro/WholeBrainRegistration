function [w] = getwindow(indice,m,s)

%
% Maryana de Carvalho Alegro
% maryana@lsi.usp.br
%
% indice = centro da janela
% M = imagem
% size = tamanho da janela

[j i] = ind2sub(size(m),indice);

x = i - floor(s/2);
y = j - floor(s/2);

%sprintf('%d - %d / %d - %d',i,j,x,y)

w = m(y:y+s-1,x:x+s-1);
