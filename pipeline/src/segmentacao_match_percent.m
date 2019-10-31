function teste1_match_percent(paciente)

% modalidades
% t1 = 1
% t1c = 2;
% flair = 3;

mod = 2;

dir_root = '/home/nex/LSI/Mestrado/implementacao/';


for p=paciente
    
    p = p+1;
    
    paciente = strcat('paciente',int2str(p-1));
    dir_mascaras = strcat(dir_root,paciente,'/mascaras/');    
    dir_resultados = strcat(dir_root,paciente,'/resultado/');
    nome_arquivo_txt = strcat(dir_root,paciente,'/',paciente,'_resultados.txt');
    
    arquivo = fopen(nome_arquivo_txt,'w');
    
    fprintf('Processando resultados do %s...\n',paciente);
    
    for s=1:3
        
        nome_mask = strcat(dir_mascaras,paciente,'_mask_',int2str(s),'_2class.bmp');
        nome_result_seg = strcat(dir_resultados,paciente,'_saida_',int2str(s),'_tumor.bmp');
        nome_result_pos = strcat(dir_resultados,paciente,'_saida_',int2str(s),'_tumor_posprocessado.bmp');
        
        %carrega mascara
        mask = imread(nome_mask);
        mask = mask(:,:,1);
        mask(mask == 255) = 0;
        
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
        
        mPA_seg(s) = PA_seg;
        mPA_pos(s) = PA_pos;
        
        %salva arquivo
        fprintf(arquivo,'Fatia %d:\n',s);
        fprintf(arquivo,'Segmentacao\n');
        fprintf(arquivo,'#PO = %d #PV = %d #FP = %d #FN = %d PA = %f\n',nPO,nPV_seg,nFP_seg,nFN_seg,PA_seg);
        fprintf(arquivo,'Pos-processamento\n');
        fprintf(arquivo,'#PO = %d #PV = %d #FP = %d #FN = %d PA = %f\n\n',nPO,nPV_pos,nFP_pos,nFN_pos,PA_pos);
        
    end
    
    med_seg = (mPA_seg(1)+mPA_seg(2)+mPA_seg(3))/3;
    med_pos = (mPA_pos(1)+mPA_pos(2)+mPA_pos(3))/3;
    
    fprintf(arquivo,'PA media SEGMENTACAO = %f\nPA media POS-PROCESSAMENTO = %f\n', med_seg,med_pos);
    
    fclose(arquivo);    
end