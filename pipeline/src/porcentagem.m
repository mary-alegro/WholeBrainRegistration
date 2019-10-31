     function p = porcentagem(histo,porcent)   
     
     %
     % P = PORCENTAGEM(HISTO,PORCENT) 
     % 
     % HISTO : histograma
     %
     % PORCENT : porcentagem
     %
     %---------------------------------------------------------------------  
     % Calcula intensidade equivalente a porentagem PORCENT,               
     % em um dado histograma.                                              
     % Ignora intensidades com 0 ocorrencias no inicio e fim do histograma 
     %---------------------------------------------------------------------  
     
     if(porcent > 1 || porcent < 0)
         error('Valor da porcentagem deve estar entre 0 e 1')
     end
     
     m1 = find(histo,1)-1;
     m2 = find(histo,1,'last')-1;     % corta fora intensidades com 0 ocorrencias, tanto no final quanto no comeco   
     
     %m1 = 0;
     %m2 = size(histo,1)-1;
     
     range = m2 - m1; 
     p = m1 + range*porcent;