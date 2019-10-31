function [d] = monta_histograma()

x = 0:0.1:200;

d1 = normpdf(x,2.5,5);
d1 = d1*8750;

d2 = normpdf(x,85,6);
d2 = d2*600;

d3 = normpdf(x,100,6);
d3 = d3*2000;

n1 = unifpdf(x,0,100);
n1 = n1*400;

d = d1+d3+d2+n1;
d = d ./ sum(x(:));

plot(x,d);