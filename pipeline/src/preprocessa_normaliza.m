function preprocessa_normaliza

%
% Aplica normalizacao as imagens
%

dir_root = '/home/nex/LSI/Mestrado/implementacao/teste_T1/';

treino_flair = [];
treino_t1 = [];
treino_t1c = [];
params_normalizacao = [1 4095 0 0.998];

%monta volumes
for i=0:3
    nome_paciente = strcat('paciente',int2str(i));  
    dir_mascarado = strcat(dir_root,nome_paciente,'/mascarado/');
    
    for n=1:3
        nome_flair = strcat(dir_mascarado,nome_paciente,'_FLAIR_',int2str(n),'.dcm');
        nome_t1 = strcat(dir_mascarado,nome_paciente,'_T1_',int2str(n),'.dcm');
        nome_t1c = strcat(dir_mascarado,nome_paciente,'_T1c_',int2str(n),'.dcm');
        
        flair = dicomread(nome_flair);
        t1 = dicomread(nome_t1);
        t1c = dicomread(nome_t1c);
        
        %concatena flair
        if isempty(treino_flair)
            treino_flair = flair;
        else
            treino_flair = cat(3,treino_flair,flair);
        end 
        
        %concatena t1
        if isempty(treino_t1)
            treino_t1 = t1;
        else
            treino_t1 = cat(3,treino_t1,t1);
        end
        
        
        %concatena t1c
        if isempty(treino_t1c)
            treino_t1c = t1c;
        else
            treino_t1c = cat(3,treino_t1c,t1c);
        end        
    end    
end



%treina normalizacao
marcas_flair = treina_normaliza_mri(params_normalizacao,treino_flair,'L1');
marcas_t1 = treina_normaliza_mri(params_normalizacao,treino_t1,'L1');
marcas_t1c = treina_normaliza_mri(params_normalizacao,treino_t1c,'L1');

%normaliza
for i=4:10
    nome_paciente = strcat('paciente',int2str(i));  
    dir_mascarado = strcat(dir_root,nome_paciente,'/mascarado/');
    dir_normalizado = strcat(dir_root,nome_paciente,'/normalizado/');
    
    for n=1:3
        nome_flair = strcat(dir_mascarado,nome_paciente,'_FLAIR_',int2str(n),'.dcm');
        nome_t1 = strcat(dir_mascarado,nome_paciente,'_T1_',int2str(n),'.dcm');
        nome_t1c = strcat(dir_mascarado,nome_paciente,'_T1c_',int2str(n),'.dcm');
        
        flair = dicomread(nome_flair);
        t1 = dicomread(nome_t1);
        t1c = dicomread(nome_t1c);
        
        %aplica normalizacao
        flair = normaliza_mri(params_normalizacao,[],flair,'L1',marcas_flair);
        t1 = normaliza_mri(params_normalizacao,[],t1,'L1',marcas_t1);
        t1c = normaliza_mri(params_normalizacao,[],t1c,'L1',marcas_t1c);
        
        nome_flair = strcat(dir_normalizado,nome_paciente,'_FLAIR_',int2str(n),'.dcm');
        nome_t1 = strcat(dir_normalizado,nome_paciente,'_T1_',int2str(n),'.dcm');
        nome_t1c = strcat(dir_normalizado,nome_paciente,'_T1c_',int2str(n),'.dcm');        
        
        %salva
        dicomwrite(uint16(flair),nome_flair);
        dicomwrite(uint16(t1),nome_t1);
        dicomwrite(uint16(t1c),nome_t1c);
    end    
end
