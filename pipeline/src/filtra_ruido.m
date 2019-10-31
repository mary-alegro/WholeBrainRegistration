function filtra_ruido(arquivos)

nArq = size(arquivos,2);

for i=1:nArq
    arquivo = arquivos(1,i);
    
    nome_saida = strcat(arquivo,'2');
    
    img = imread(char(arquivo));
    img_out = anisodiff2D(img,3,0.1429,10,2);
    
    imwrite(gscale(img_out),char(nome_saida),'TIFF');
    
end
