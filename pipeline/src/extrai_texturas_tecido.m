function extrai_texturas_tecido(diretorios)

ext_T1 = '_T1.tif';
ext_T1c = '_T1c.tif';
ext_FLAIR = '_FLAIR.tif';
ext_4class = '_mask_4class.bmp';
ext_tecido = '_dados_tecido.mat';


nDirs = size(diretorios,2);

for index = 1:nDirs
    diretorio = diretorios(1,index);
    
    diretorio
    
    mascara = strcat(diretorio,'/',diretorio,ext_4class);
    T1 = strcat(diretorio,'/',diretorio,ext_T1);
    T1c = strcat(diretorio,'/',diretorio,ext_T1c);    
    FLAIR = strcat(diretorio,'/',diretorio,ext_FLAIR);
    saida = strcat(diretorio,'/',diretorio,ext_tecido);
    
    mask = imread(char(mascara));
    img_T1 = imread(char(T1));
    img_T1c = imread(char(T1c));
    img_FLAIR = imread(char(FLAIR));
    
    
    struct = extrai_dados_tecido(img_T1,img_T1c,img_FLAIR,mask);
    
   
    save(char(saida),'struct'); %salva arquivo com dados extraidos
end
    