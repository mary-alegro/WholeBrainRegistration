 function [s1_ s2_ marcas] = calcula_marcas_normalizacao2(params, volume, L) 
 
 %
 % [S1_ S2_ MARCAS] = CALCULA_MARCAS_NORMALIZACAO2(PARAMS, VOLUME, L) 
 %
 % S1_ e S2_ : s1 e s2 atualizados, no caso de alguma imagem de teste nao
 %             seguir as resgras impostas pelos Teoremas 1, 2 e 3 dos
 %             artigos
 %
 % MARCAS : vetor com o valor medio das marcas calculadas
 %
 % PARAMS : parametros ([s1 s2 pc1 pc2])
 %
 % VOLUME : pilha de imagens
 %
 % L : opcao de marcas
 %
 %---------------------------------------------------------------------
 % Calcula marcas medias a partir do histograma da imagem de um volume 
 %---------------------------------------------------------------------
 
 s1 = params(1);
 s2 = params(2);
 pc1 = params(3);
 pc2 = params(4); 

 
 [rows,cols,N] = size(volume); 
 
 nMarcos = 1; %no. marcas que vao ser calculadas (sem p1 e p2)
 nSegs = 2; %no. segmentos em que o eixo das intensidades eh dividido (contando p1 e p2)

 
 if strcmpi(L,'L3')
     nMarcos = 3;
     nSegs = 4;
 elseif strcmpi(L,'L4')
     nMarcos = 9;
     nSegs = 10;
 end
 
 segmentos = zeros(2,nSegs); % linha 1 = min / linha 2 = max
 segmentos(1,:) = max(volume(:)); 
 %minMedias = zeros(1,nMarcos);
 %minMedias(:) = s2; %inicia vetor de medias minimas
 
 %mapeia     
     
 medias = zeros(N,nMarcos); %vetor que guarda marcos (imagem x marca) sera usada no calculo das marcas medias 
 
 for i = 1:N
    img = volume(:,:,i); % pega fatia i

    marcos = acha_locais_normalizacao(img,pc1,pc2,L); %acha as marcas da fatia i
    len = size(marcos,1);
    
    %pega min e max dos segmentos
    for s = 2:len
        if (marcos(s) - marcos(s-1)) < segmentos(1,s-1)
            segmentos(1,s-1) = marcos(s) - marcos(s-1);
        elseif (marcos(s) - marcos(s-1)) > segmentos(2,s-1)
            segmentos(2,s-1) = marcos(s) - marcos(s-1);
        end            
    end
    
    p1 = marcos(1);
    p2 = marcos(len);    
    for j = 2:len-1 % pega os 'mis' (marcas)
        x = marcos(j);

        mi = s1 + (x - p1)/(p2 - p1) * (s2 - s1); %mapeia linearmente        

        medias(i,j-1) = mi;
    end    
 end  

 %medias
 if N > 1
    marcas = round(sum(medias)/N); %calcula medias, caso entrada tenha mais de 1 imagem
 else
    marcas = medias;
 end
 
 % verifica teoremas
 tmp = [s1; marcas; s2];
 for t = 1:size(marcas,1)
     
 end
 

 

     
     
     

         
         