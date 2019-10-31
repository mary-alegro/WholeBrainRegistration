function G = gaborfilter2(S,F,W,P)

%
% G = gaborfilter2(S,F,W,P)
%
% S : sigma - desvio padrao do envelope gaussiano
% (F,W) : frequencia espacial da senoide em coordenada polar. F =
% magnitude, W = angulo
% P : Fase da senoide 
%


size=fix(1.5/S); % exp(-1.5^2*pi) < 0.1%
%k=2*pi*S^2;
%F=S^2/sqrt(2*pi);
k=1;
for x=-size:size
    for y=-size:size
        G(size+x+1,size+y+1)=k*exp(-pi*S^2*(x*x+y*y))*...
            (exp(j*(2*pi*F*(x*cos(W)+y*sin(W))+P))-exp(-pi*(F/S)^2+j*P));
    end
end