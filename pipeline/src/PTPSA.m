function [FD] = PTPSA(img)

%
% Maryana de Carvalho Alegro
% maryana@lsi.usp.br
%
% [FD] = PTPSA(img)
%
% img : fragmento de imagem que tera a FD calculada (deve ter lados iguais de tamanho 2n)
% FD : dimensao fractal
%
% Calcula dimensao fractal (FD) pelo algoritmo
% Piecewise-Triangular-Prism-Surface-Area
%

[r c N] = size(img);

A = double(img(1,1));
B = double(img(r,1));
C = double(img(1,c));
D = double(img(r,c));

h = (A+B+C+D)/4;

%S1
a1 = sqrt((A-B)^2 + r^2);
b1 = sqrt((A-h)^2 + 0.5*r^2);
c1 = sqrt((B-h)^2 + 0.5*r^2);
l1 = (a1+b1+c1)/2;
S1 = sqrt(l1*(l1-a1)*(l1-b1)*(l1-c1));

%S2
a1 = sqrt((A-C)^2 + r^2);
b1 = sqrt((A-h)^2 + 0.5*r^2);
c1 = sqrt((C-h)^2 + 0.5*r^2);
l1 = (a1+b1+c1)/2;
S2 = sqrt(l1*(l1-a1)*(l1-b1)*(l1-c1));

%S3
a1 = sqrt((C-D)^2 + r^2);
b1 = sqrt((C-h)^2 + 0.5*r^2);
c1 = sqrt((D-h)^2 + 0.5*r^2);
l1 = (a1+b1+c1)/2;
S3 = sqrt(l1*(l1-a1)*(l1-b1)*(l1-c1));

%S4
a1 = sqrt((B-D)^2 + r^2);
b1 = sqrt((B-h)^2 + 0.5*r^2);
c1 = sqrt((D-h)^2 + 0.5*r^2);
l1 = (a1+b1+c1)/2;
S4 = sqrt(l1*(l1-a1)*(l1-b1)*(l1-c1));

FD = log(S1+S2+S3+S4)/log(r);





