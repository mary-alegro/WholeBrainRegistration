function preprocessa_converte_nii2dicom

dir_root = '/home/nex/LSI/Mestrado/implementacao/teste_T1/';

for i = 0:10
    dir_paciente = strcat(dir_root,'paciente',int2str(i),'/');
    dir_dicom = strcat(dir_root,'paciente',int2str(i),'/dcm/');
    nome_nii_flair = strcat(dir_paciente,'/nii/paciente',int2str(i),'_FLAIR.nii');
    nome_nii_t1 = strcat(dir_paciente,'/nii/paciente',int2str(i),'_T1.nii');
    nome_nii_t1c = strcat(dir_paciente,'/nii/paciente',int2str(i),'_T1c.nii');
    
    nii_flair = load_nii(nome_nii_flair);
    nii_t1 = load_nii(nome_nii_t1);
    nii_t1c = load_nii(nome_nii_t1c);
    
    %converte flair
    for n = 1:3
        img = nii_flair.img;
        dcm = img(:,:,n);
        
        %rotaciona e espelha
        dcm = rot90(dcm);
        dcm = mirror(dcm);
        
        nome_dcm = strcat(dir_dicom,'paciente',int2str(i),'_FLAIR_',int2str(n),'.dcm');
        dicomwrite(dcm,nome_dcm);
    end
    
    %converte t1
    for n = 1:3
        img = nii_t1.img;
        dcm = img(:,:,n);
        
        %rotaciona e espelha
        dcm = rot90(dcm);
        dcm = mirror(dcm);
        
        nome_dcm = strcat(dir_dicom,'paciente',int2str(i),'_T1_',int2str(n),'.dcm');
        dicomwrite(dcm,nome_dcm);
    end
    
    %converte t1c
    for n = 1:3
        img = nii_t1c.img;
        dcm = img(:,:,n);
        
        %rotaciona e espelha
        dcm = rot90(dcm);
        dcm = mirror(dcm);
        
        nome_dcm = strcat(dir_dicom,'paciente',int2str(i),'_T1c_',int2str(n),'.dcm');
        dicomwrite(dcm,nome_dcm);
    end
end