function mask = extrai_cerebro(img,nIter,contraste)

%
% MASK = EXTRAI_CEREBRO(IMG,NITER,contraste)
%
% MASK : MASCARA RESULTANTE DO PROCESSAMENTO
%
% IMG : IMAGEM (TRANSFORMACAO DE CONTRASTE AJUSTADA PARA FLAIR DE 8 BITS, SE A IMAGEM FOR DE OUTRA CLASSE, SERA CONVERTIDA AUTOMATICAMENTE)
%
% CONTRASTE : FLAG QUE INDICA SE A IMAGEM PROCESSADA SERA ORIGINA OU COM
% COMTRASTE. (1 = JUSTA CONTRASTE, 0 = IMAGEM ORIGINA)
%
% NITER : NUMERO DE ITERACOES
%
%---------------------------------------------------------------------
%              Extrai cerebro da caixa craniana e fundo                         
%  Utiliza correcao de contraste, morfologia e fit de gaussiana para  
%  criar mascara inicial.                                             
%  Utiliza contornos ativos para segmentar a area do cerebro          
%---------------------------------------------------------------------

%reescala imagem, e converte para uint8
img = gscale(img);

[mascara,imagem] = gera_mascara_inicial(img); %gera mascara inicial

%contorno ativo
if contraste == 1
    mask = region_seg(imagem, mascara, nIter);
else
    mask = region_seg(img, mascara, nIter);
end

mask = tapa_buracos(mask); %tapa os buracos
