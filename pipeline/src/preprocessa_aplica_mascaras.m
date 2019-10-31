function preprocessa_aplica_mascaras

dir_root = '/home/nex/LSI/Mestrado/implementacao/teste_T1/';


for i = 4:10
    nome_paciente = strcat('paciente',int2str(i));    
    dir_mascaras = strcat(dir_root,nome_paciente,'/mascaras/');
    dir_registrados = strcat(dir_root,nome_paciente,'/registrado/');
    dir_mascarados = strcat(dir_root,nome_paciente,'/mascarado/');
    
    for n=1:3
        nome_msk = strcat(dir_mascaras,nome_paciente,'_mask_',int2str(n),'.bmp');
        nome_flair = strcat(dir_registrados,nome_paciente,'_FLAIR_',int2str(n),'.dcm');
        nome_t1 = strcat(dir_registrados,nome_paciente,'_T1_',int2str(n),'.dcm');
        nome_t1c = strcat(dir_registrados,nome_paciente,'_T1c_',int2str(n),'.dcm');
        
        msk = imread(nome_msk);
        msk = msk(:,:,1);
        
        flair = dicomread(nome_flair);
        t1 = dicomread(nome_t1);
        t1c = dicomread(nome_t1c);
        
        %mascara
        flair(msk == 0) = 0;
        t1(msk == 0) = 0;
        t1c(msk == 0) = 0;
        
        nome_flair = strcat(dir_mascarados,nome_paciente,'_FLAIR_',int2str(n),'.dcm');
        nome_t1 = strcat(dir_mascarados,nome_paciente,'_T1_',int2str(n),'.dcm');
        nome_t1c = strcat(dir_mascarados,nome_paciente,'_T1c_',int2str(n),'.dcm');
        
        dicomwrite(flair,nome_flair);
        dicomwrite(t1,nome_t1);
        dicomwrite(t1c,nome_t1c);
    end    
end