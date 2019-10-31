function saida = interpola(entrada)

indices = find(entrada == 0);
S = size(indices,1);

saida = entrada;

for i = 1:S
    indice = indices(i);
    [a b] = busca_vizinhos(indice,saida);
    media = floor(abs(a-b)/2);
    if a < b
        novo_valor = a + media;
    else
        novo_valor = b + media;
    end        
    saida(indice) = novo_valor;
end



%busca os vizinhos nao zero do indice, retorna zero se nao existir
function [a b] = busca_vizinhos(ind,vetor)

a = 0;
b = 0;

len = size(vetor,1); %espera-se vetor coluna

%pega vizinho anterior
for i = ind:-1:1
    if vetor(i) ~= 0
        a = vetor(i);
        break;
    end
end

%pega vizinho posterior
for i = ind:len
    if vetor(i) ~= 0
        b = vetor(i);
        break;
    end
end
