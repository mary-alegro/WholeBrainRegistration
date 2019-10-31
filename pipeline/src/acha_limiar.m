function limiar = acha_limiar(img)

%acha limiar fazendo fit de uma gaussiana no maior pico do histograma


[count,x] = imhist(img); % imagem tem que estar com contraste ajustado

%corta extremos do histograma
count(1) = 0;
S = size(count,1);
count(S) = 0;

maximo = max(count);
half_max = floor(maximo/2);

indice_max = find(count == maximo);

if size(indice_max,1) > 1
    indice_max = min(indice_max); %protege contra ocorrencia de mais de caso com mesmo valor
end

%acha limites do histograma

%acha limite inferior
indice_inf = acha_limite_inferior(count,indice_max);

%acha limite superior
indice_sup = acha_limite_superior(count,indice_max);

%pega limite mais proximo do pico
menor_dist = abs(indice_max - indice_inf);

if abs(indice_max - indice_sup) < menor_dist
    menor_dist = abs(indice_max - indice_sup);
end

indice_inf = indice_max - menor_dist;
indice_sup = indice_max + menor_dist;

histograma = count(indice_inf:indice_sup);
indice_max_hist = find(histograma == maximo);

if size(indice_max_hist,1) > 1
    indice_max_hist = min(indice_max_hist); %protege contra ocorrencia de mais de caso com mesmo valor
end

histograma = interpola(histograma); %interpola histograma, para tirar zeros gerados pelo ajuste de contraste

%realiza fit de gaussiana no histograma interpolado
x = 1:size(histograma,1);
fitted = fit(x',histograma,'gauss1');

%plot de curva
%plot(x,histograma,'o');
%hold on;
%plot(fitted,'r');
%legend('Histograma','Gaussiana');
%hold off;

coeficientes = coeffvalues(fitted); %pega os coeficientes do objeto gerado ([a1 b1 c1])
                                    % a1 -> scaling, b1 -> media, c1-> desvio padrao 
media = coeficientes(2);
desvio = coeficientes(3);
media = floor(media);
desvio = floor(desvio);

desloc = indice_max_hist - media; %deslocamento entre pico e media encontrada

media_count = indice_max - desloc; %acha media no histrograma completo

limiar = media_count - (2*desvio); %limiar eh 2 desvios padroes da media

    

%acha o limite inferior do histograma
function indice = acha_limite_inferior(vetor,ind_max)
    
    
    vetor(ind_max+1:end) = 0;

    half_max = floor(vetor(ind_max)/2);    
    anterior = 0;
    atual = 256;
    limite = 0;
    
    for i = ind_max-1:-1:1
        atual = vetor(i);
        
        if atual == 0
            continue;
        end
        
        if atual < half_max
            limite = atual;
            if abs(anterior - half_max) < abs(atual - half_max)
                limite = anterior;
            end
            break;
        else
            anterior = atual;
        end       
        
    end
    
    indice = find(vetor == limite,1,'last');



%acha o limite superior do histograma
function indice = acha_limite_superior(vetor,ind_max)

    vetor(1:ind_max-1) = 0;
    
    len = size(vetor,1);
    half_max = floor(vetor(ind_max)/2);  
    anterior = 0;
    atual = 256;
    limite = 0;
    
    for i = ind_max+1:len
        atual = vetor(i);
        
        if atual == 0
            continue;
        end
        
        if atual < half_max
            limite = atual;
            if abs(anterior - half_max) < abs(atual - half_max)
                limite = anterior;
            end
            break;
        else
            anterior = atual;
        end
        
    end
    
    indice = find(vetor == limite,1,'first');








