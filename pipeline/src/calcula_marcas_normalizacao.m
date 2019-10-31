 function [marcas] = calcula_marcas_normalizacao(params, volume, L) 
 
 %
 % [MARCAS] = CALCULA_MARCAS_NORMALIZACAO(PARAMS, VOLUME, L) 
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
 if strcmpi(L,'L3')
     nMarcos = 3;
 elseif strcmpi(L,'L4')
     nMarcos = 9;
 end
 
 medias = zeros(N,nMarcos); %vetor que guarda marcos (imagem x marca) sera usada no calculo das marcas medias
 
 for i = 1:N
    img = volume(:,:,i); % pega fatia i
    
    marcos = acha_locais_normalizacao(img,pc1,pc2,L); %acha as marcas da fatia i
    
    len = size(marcos,1);
    p1 = marcos(1);
    p2 = marcos(len);    
    for j = 2:len-1 % pega os 'mis' (marcas)
        x = marcos(j);
        
        mi = s1 + (x - p1)/(p2 - p1) * (s2 - s1); %mapeia linearmente        
        
        medias(i,j-1) = mi;
    end   
 end  

 if N > 1
    marcas = round(sum(medias)/N); %calcula medias, caso entrada tenha mais de 1 imagem
 else
    marcas = medias;
 end
 

 

     
     
     

         
         