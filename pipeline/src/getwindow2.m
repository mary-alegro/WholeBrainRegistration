function [w] = getwindow2(r,c,m,s)
% (r,c) = linha,coluna do centro da janela
% M = imagem
% s = tamanho da janela


x = c - floor(s/2);
y = r - floor(s/2);

%sprintf('%d - %d / %d - %d',i,j,x,y)

w = m(y:y+s-1,x:x+s-1);