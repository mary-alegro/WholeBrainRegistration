 function [marcos] = acha_locais_normalizacao(imagem, pc1, pc2, L) 
 
 %
 % [MARCOS] = ACHA_LOCAIS_NORMALIZACAO(IMAGEM, PC1, PC2, L)
 %
 % IMAGEM : imagem cujo histograma sera utilizado
 %
 % PC1 e PC2 : porcentagens do inicio e fim do histograma
 %
 % L : opcao de marcas (landmarks)
 %-----------------------------------------------------------------------
 % Acha localizacao das marcas (landmarks) no histograma da imagem     
 % (assume imagem jah sem o fundo)                                    
 %-----------------------------------------------------------------------
          
    
     %histo = imhist(imagem);
     histo = histograma(imagem);
     histo(1) = 0; %corta fora ocorrencia de pixeis com valor 0
     
     p1 = porcentagem(histo,pc1); %  primeira porcentagem
     p2 = porcentagem(histo,pc2); %  segunda porcentagem
     
     if p1 > 0
         histo(1:ceil(p1)) = 0;
     end
     
     if p2 > 0 && p2 < size(histo,1);
         histo(floor(p2):end) = 0;
     end
     
     switch(upper(L))         
         case 'L1'
             % {p1,p2,mi} -> pega pico do histograma como marco
             marcos = zeros(3,1);
             marcos(1) = p1;             
             maximo = max(histo);
             I = find(histo == maximo);
             marcos(2) = I(1)-1;
             marcos(3) = p2;             
             
         case 'L2'
             %{p1,p2,mi50}
             marcos = zeros(3,1);
             marcos(1) = p1;             
             marcos(2) = porcentagem(histo,0.5); % 50% do histograma
             marcos(3) = p2;
             
         case 'L3'
             %{p1, p2, mi25, mi50 ,mi75}
             marcos = zeros(5,1);
             marcos(1) = p1;             
             marcos(2) = porcentagem(histo,0.25);
             marcos(3) = porcentagem(histo,0.5);  
             marcos(4) = porcentagem(histo,0.75);
             marcos(5) = p2;
             
         case 'L4'
             %{p1, p2, mi10, mi20 ,mi30,..., mi90}
             marcos = zeros(11,1);
             marcos(1) = p1;                         
             j = 2;
             for i = 0.1:0.1:0.9
                 marcos(j) = porcentagem(histo,i);
                 j = j+1;
             end
             marcos(11) = p2; 
     end