function [squares] = quadricula(imagem)
%so imgs quadradas

[rows,cols] = size(imagem);
if(rows ~= cols)
    error('somente imagens quadradas')
end

squares = zeros(4096,16);
count = 1;
for r = 1:64:193
    for c= 1:64:193
            tmp = imagem(r:r+63,c:c+63);
            squares(:,count) = tmp(:);
            count = count+1;
    end
end

