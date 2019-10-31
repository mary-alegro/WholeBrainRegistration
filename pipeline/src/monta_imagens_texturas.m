function monta_imagens_texturas


% modalidades
% t1 = 1
% t1c = 2;
% flair = 3;

mod = 2;

dir_root = '/home/nex/LSI/Mestrado/implementacao/';
  
for p=0:3
    
    p = p+1;
    
    paciente = strcat('paciente',int2str(p-1));
    dir_mascaras = strcat(dir_root,paciente,'/mascaras/');    
    nome_mask1 = strcat(dir_mascaras,paciente,'_mask_1_2class.bmp');
    nome_mask2 = strcat(dir_mascaras,paciente,'_mask_2_2class.bmp');
    nome_mask3 = strcat(dir_mascaras,paciente,'_mask_3_2class.bmp');
    nome_dados = strcat(dir_root,paciente,'/',paciente,'_data2.mat');
    
    dir_texturas = strcat(dir_root,paciente,'/texturas/');
    
    %carrega mascaras
    mask(1).m = imread(nome_mask1);
    mask(1).m = mask(1).m(:,:,1);
    mask(2).m = imread(nome_mask2);
    mask(2).m = mask(2).m(:,:,1);
    mask(3).m = imread(nome_mask3);
    mask(3).m = mask(3).m(:,:,1);
    
    %carrega dados
    dados = load(nome_dados);    
    
    indices(1).ind = find(mask(1).m ~= 0);
    indices(2).ind = find(mask(2).m ~= 0);
    indices(3).ind = find(mask(3).m ~= 0);    
    
    for s=1
        img1 = zeros(size(mask(s).m));
        img2 = img1;
        img3 = img1;
        img4 = img1;
        img5 = img1;
        img6 = img1;

        img1(indices(s).ind(:)) = dados.struct.mri(mod).s(s).ASM(:,1);
        img2(indices(s).ind(:)) = dados.struct.mri(mod).s(s).contrast(:,1);
        img3(indices(s).ind(:)) = dados.struct.mri(mod).s(s).correlation(:,1);
        img4(indices(s).ind(:)) = dados.struct.mri(mod).s(s).IDM(:,1);        
        img5(indices(s).ind(:)) = dados.struct.mri(mod).s(s).sum_average(:,1);        
        img6(indices(s).ind(:)) = dados.struct.mri(mod).s(s).entropy(:,1);         
        imwrite(gscale(img1),strcat(dir_texturas,paciente,'_',int2str(s),'T1c_ASM.bmp'),'BMP');
        imwrite(gscale(img2),strcat(dir_texturas,paciente,'_',int2str(s),'T1c_contrast.bmp'),'BMP');
        imwrite(gscale(img3),strcat(dir_texturas,paciente,'_',int2str(s),'T1c_correlation.bmp'),'BMP');
        imwrite(gscale(img4),strcat(dir_texturas,paciente,'_',int2str(s),'T1c_IDM.bmp'),'BMP');
        imwrite(gscale(img5),strcat(dir_texturas,paciente,'_',int2str(s),'T1c_sum_average.bmp'),'BMP');
        imwrite(gscale(img6),strcat(dir_texturas,paciente,'_',int2str(s),'T1c_entropy.bmp'),'BMP');
        
        img1(indices(s).ind(:)) = dados.struct.mri(mod-1).s(s).ASM(:,1);
        img2(indices(s).ind(:)) = dados.struct.mri(mod-1).s(s).contrast(:,1);
        img3(indices(s).ind(:)) = dados.struct.mri(mod-1).s(s).correlation(:,1);
        img4(indices(s).ind(:)) = dados.struct.mri(mod-1).s(s).IDM(:,1);        
        img5(indices(s).ind(:)) = dados.struct.mri(mod-1).s(s).sum_average(:,1);        
        img6(indices(s).ind(:)) = dados.struct.mri(mod-1).s(s).entropy(:,1);        
        imwrite(gscale(img1),strcat(dir_texturas,paciente,'_',int2str(s),'T1_ASM.bmp'),'BMP');
        imwrite(gscale(img2),strcat(dir_texturas,paciente,'_',int2str(s),'T1_contrast.bmp'),'BMP');
        imwrite(gscale(img3),strcat(dir_texturas,paciente,'_',int2str(s),'T1_correlation.bmp'),'BMP');
        imwrite(gscale(img4),strcat(dir_texturas,paciente,'_',int2str(s),'T1_IDM.bmp'),'BMP');
        imwrite(gscale(img5),strcat(dir_texturas,paciente,'_',int2str(s),'T1_sum_average.bmp'),'BMP');
        imwrite(gscale(img6),strcat(dir_texturas,paciente,'_',int2str(s),'T1_entropy.bmp'),'BMP');
        
        img1(indices(s).ind(:)) = dados.struct.mri(mod+1).s(s).ASM(:,1);
        img2(indices(s).ind(:)) = dados.struct.mri(mod+1).s(s).contrast(:,1);
        img3(indices(s).ind(:)) = dados.struct.mri(mod+1).s(s).correlation(:,1);
        img4(indices(s).ind(:)) = dados.struct.mri(mod+1).s(s).IDM(:,1);        
        img5(indices(s).ind(:)) = dados.struct.mri(mod+1).s(s).sum_average(:,1);        
        img6(indices(s).ind(:)) = dados.struct.mri(mod+1).s(s).entropy(:,1);        
        imwrite(gscale(img1),strcat(dir_texturas,paciente,'_',int2str(s),'FLAIR_ASM.bmp'),'BMP');
        imwrite(gscale(img2),strcat(dir_texturas,paciente,'_',int2str(s),'FLAIR_contrast.bmp'),'BMP');
        imwrite(gscale(img3),strcat(dir_texturas,paciente,'_',int2str(s),'FLAIR_correlation.bmp'),'BMP');
        imwrite(gscale(img4),strcat(dir_texturas,paciente,'_',int2str(s),'FLAIR_IDM.bmp'),'BMP');
        imwrite(gscale(img5),strcat(dir_texturas,paciente,'_',int2str(s),'FLAIR_sum_average.bmp'),'BMP');
        imwrite(gscale(img6),strcat(dir_texturas,paciente,'_',int2str(s),'FLAIR_entropy.bmp'),'BMP');
    end
end 