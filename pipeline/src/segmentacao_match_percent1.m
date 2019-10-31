function segmentacao_match_percent1(pacientes,medico)

%
% Calcula eficiencia da segmentacao utilizando a metrica descrita em:
% "Tumor Segmentation from Magnetic Resonance Imaging by Learning
% via One-class Support Vector Machine" - Jianguo Zhang, Kai-kuang Ma, Meng Hwa Er 
%




dir_root = '/home/nex/LSI/Mestrado/implementacao/';



for p=pacientes
    
    nPO_medio = 0;
    
    paciente = strcat('paciente',int2str(p));
    dir_mascaras = strcat(dir_root,paciente,'/mascaras/');    
    dir_resultados = strcat(dir_root,paciente,'/resultado/');
    nome_arquivo_txt = strcat(dir_root,paciente,'/',paciente,'_medico',int2str(medico),'_resultados_artigo1.txt');
    
    arquivo = fopen(nome_arquivo_txt,'w');
    
    fprintf('Processando resultados do %s...\n',paciente);
    
    for s=1:3
        
        nome_mask = strcat(dir_mascaras,paciente,'_mask',int2str(medico),'_',int2str(s),'_2class.bmp');
        nome_result_seg = strcat(dir_resultados,paciente,'_saida_',int2str(s),'_medico',int2str(medico),'_tumor.bmp');
        nome_result_pos = strcat(dir_resultados,paciente,'_saida_',int2str(s),'_medico',int2str(medico),'_tumor_posprocessado.bmp');
        
        %carrega mascara
        mask = imread(nome_mask);
        mask = mask(:,:,1);
        mask(mask == 255) = 0; %tira tecido normal da mascara (so sobra tumor)        
        
        %carrega segmentacao
        img_seg = imread(nome_result_seg);
        img_seg = img_seg(:,:,1);
        
        %carrega segmentacao posprocessada
        img_pos = imread(nome_result_pos);
        img_pos = img_pos(:,:,1);
        
        
        %calcula valores acerto
        PO = find(mask ~= 0);
        nPO = length(PO);
                
        %segmentacao
        PV_seg = intersect(find(img_seg ~= 0), PO);
        FP_seg = intersect(find(mask == 0),find(img_seg ~= 0));
        FN_seg = intersect(PO,find(img_seg == 0));
        
        nPV_seg = length(PV_seg);
        nFP_seg = length(FP_seg);
        nFN_seg = length(FN_seg);        
        
        PA_seg = nPV_seg/nPO;
        
        %pos-processamento
        PV_pos = intersect(find(img_pos ~= 0), PO);
        FP_pos = intersect(find(mask == 0),find(img_pos ~= 0));
        FN_pos = intersect(PO,find(img_pos == 0));
        
        nPV_pos = length(PV_pos);
        nFP_pos = length(FP_pos);
        nFN_pos = length(FN_pos);        
        
        PA_pos = nPV_pos/nPO;
        
        %para calcular medias
        pos.PV(s) = nPV_pos;
        pos.FP(s) = nFP_pos;
        pos.FN(s) = nFN_pos;
        pos.PA(s) = PA_pos;
        
        %salva arquivo
        fprintf(arquivo,'Fatia %d:\n',s);
%         fprintf(arquivo,'Segmentacao\n');
%         fprintf(arquivo,'#PO = %d #PV = %d #FP = %d #FN = %d PA = %f\n',nPO,nPV_seg,nFP_seg,nFN_seg,PA_seg);
        fprintf(arquivo,'Pos-processamento\n');
        fprintf(arquivo,'#PO = %d #PV = %d #FP = %d #FN = %d PA = %f\n\n',nPO,nPV_pos,nFP_pos,nFN_pos,PA_pos);
        
        
        
        nPO_medio = nPO_medio + nPO;
        
    end
    
    mPV_pos = (pos.PV(1)+pos.PV(2)+pos.PV(3))/3;
    mFP_pos = (pos.FP(1)+pos.FP(2)+pos.FP(3))/3;
    mFN_pos = (pos.FN(1)+pos.FN(2)+pos.FN(3))/3;
    mPA_pos = (pos.PA(1)+pos.PA(2)+pos.PA(3))/3;
    nPO_medio = nPO_medio/3;
    
    fprintf(arquivo,'MEDIAS POSPROCESSAMENTO\n #PO: %f #PV: %f #FP: %f #FN: %f PA: %f\n',nPO_medio,mPV_pos,mFP_pos,mFN_pos,mPA_pos);
    
    fclose(arquivo);    
end