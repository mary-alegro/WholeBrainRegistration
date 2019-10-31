function temp_proporcao_sobre_PO(medico)


dir_root = '/home/nex/LSI/Mestrado/implementacao/';

nome_arquivo_txt = strcat(dir_root,'resultados_tabela.csv');    
arquivo = fopen(nome_arquivo_txt,'w');
fprintf(arquivo,'Medico%d\n#PO;#PV;#FP;#FN;PA;#FP/#PO;#FN/PO\n',medico);

for p=0:10
    
    nPO_medio = 0;
    
    paciente = strcat('paciente',int2str(p));
    dir_mascaras = strcat(dir_root,paciente,'/mascaras/');    
    dir_resultados = strcat(dir_root,paciente,'/resultado/');   

    
    fprintf('Processando resultados do %s...\n',paciente);
    
    for s=1:3
        
        nome_mask = strcat(dir_mascaras,paciente,'_mask',int2str(medico),'_',int2str(s),'_2class.bmp');        
        nome_result_pos = strcat(dir_resultados,paciente,'_saida_',int2str(s),'_medico',int2str(medico),'_tumor_posprocessado.bmp');
        
        %carrega mascara
        mask = imread(nome_mask);
        mask = mask(:,:,1);
        mask(mask == 255) = 0; %tira tecido normal da mascara (so sobra tumor)        
                
        %carrega segmentacao posprocessada
        img_pos = imread(nome_result_pos);
        img_pos = img_pos(:,:,1);
                
        %calcula valores acerto
        PO = find(mask ~= 0);
        nPO = length(PO);
        
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
        fprintf(arquivo,'%d;%d;%d;%d;%.3f;%.3f;%.3f\n',nPO,nPV_pos,nFP_pos,nFN_pos,(PA_pos*100),(nFP_pos/nPO)*100,(nFN_pos/nPO)*100);
        
        
        
        nPO_medio = nPO_medio + nPO;
        
    end    
        
end
fclose(arquivo);