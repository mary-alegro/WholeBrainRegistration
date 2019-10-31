function mask = tapa_buracos(img)

img = im2bw(img);
img = ~img; %inverte img

%fecha eventuais buracos

%acha fundo
[labels num] = bwlabel(img);

maior = 0;
fundo = 0;

for i = 1:num
    n = size(labels(labels == i),1);
    
    if n > maior
        maior = n;
        fundo = i;
    end    
end

for i = 1:num
    if i ~= fundo
        img(labels == i) = 0;
    end
end

mask = ~img;