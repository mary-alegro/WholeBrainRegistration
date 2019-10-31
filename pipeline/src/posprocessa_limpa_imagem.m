function posprocessa_limpa_imagem(medico)

% posprocessa_limpa_imagem
%
% Aplica operacoes morfologicas para retirar estruturas conexas criadas
% erroneamente apos a segmentacao
%

dir_root = '/home/nex/LSI/Mestrado/implementacao/';

for p = 0:10    
    
    paciente = strcat('paciente',int2str(p));
%    dir_mascaras = strcat(dir_root,paciente,'/mascaras/');  
    dir_resultado = strcat(dir_root,paciente,'/resultado/');  
%     nome_mask1 = strcat(dir_mascaras,paciente,'_mask_1_2class.bmp');
%     nome_mask2 = strcat(dir_mascaras,paciente,'_mask_2_2class.bmp');
%     nome_mask3 = strcat(dir_mascaras,paciente,'_mask_3_2class.bmp');
% 
%     mask(1).m = imread(nome_mask1);
%     mask(1).m = mask(1).m(:,:,1);
%     mask(2).m = imread(nome_mask2);
%     mask(2).m = mask(2).m(:,:,1);
%     mask(3).m = imread(nome_mask3);
%     mask(3).m = mask(3).m(:,:,1);
    
    fprintf('Pos-processando %s...\n',paciente);
    
    for s=1:3
        
        nome_resultado = strcat(dir_resultado,paciente,'_saida_',int2str(s),'_medico',int2str(medico),'_tumor.bmp');
        nome_posproc = strcat(dir_resultado,paciente,'_saida_',int2str(s),'_medico',int2str(medico),'_tumor_posprocessado.bmp');
        
        img = imread(nome_resultado);
        img = img(:,:,1);
        
        %pega maior regiao
        [labels num] = bwlabel(img);
        maior = 0;
        label = 0;        
        for i = 1:num
            n = size(labels(labels == i),1);

            if n > maior
                maior = n;
                label = i;
            end    
        end
        img2 = zeros(size(img));
        img2(labels == label) = 255;
        
        %tapa os buracos
        img3 = tapa_buracos(img2);  
        
        se = [1 1 1; 1 1 1; 1 1 1];
        
        img = imerode(img3,se);
        
                %pega maior regiao
        [labels num] = bwlabel(img);
        maior = 0;
        label = 0;        
        for i = 1:num
            n = size(labels(labels == i),1);

            if n > maior
                maior = n;
                label = i;
            end    
        end
        img2 = zeros(size(img));
        img2(labels == label) = 255;        
        
        %tapa os buracos
        img3 = tapa_buracos(img2);
        
        img3 = imdilate(img3,se);
        
        %salva
        imwrite(img3,nome_posproc,'BMP'); 
        
    end        
end