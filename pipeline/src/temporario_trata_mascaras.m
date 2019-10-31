function temporario_trata_mascaras


for i=1:3
    for n=1:3
        diretorio = '/home/nex/LSI/Mestrado/implementacao/teste_T1/paciente';
        mascara = strcat(diretorio,int2str(i),'/mascaras/paciente',int2str(i),'_mask_',int2str(n),'.bmp');
        
        img = imread(mascara);
        img = img(:,:,1);
        
        img = threshold(img, 100);
        
        imwrite(img,mascara,'BMP');
    end
end