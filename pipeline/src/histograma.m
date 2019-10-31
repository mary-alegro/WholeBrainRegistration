function H = histograma(img,zera1stBin)

%
% H = HISTOGRAMA(IMG)
%
% Monta histograma onde o range varia de acordo com o maior valor da imagem
% Restricao: menor intensidade deve ser maior ou igual a ZERO
%
%
% H = HISTOGRAMA(IMG,1)
%
% Monta histograma onde o range varia de acordo com o maior valor da imagem
% e primeiro 'bin' zerado (ocorrencia de intensidades ZERO)
% Restricao: menor intensidade deve ser maior ou igual a ZERO
%

mTom = max(img(:));

H = zeros(mTom+1,1);

for i = 0:mTom
    H(i+1) = size(img(img == i),1);
end

if nargin > 1
    if zera1stBin == 1
        H(1) = 0;
    end
end