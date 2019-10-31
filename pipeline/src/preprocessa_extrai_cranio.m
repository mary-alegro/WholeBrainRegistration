function preprocessa_extrai_cranio

%
% Gera iterativamente mascaras para extrair cranio e fundo
%

dir_root = '/home/nex/LSI/Mestrado/implementacao/teste_T1/';


for i = 4:10
    
    dir_registrado = strcat(dir_root,'paciente',int2str(i),'/registrado/');
    nIter = 160;
    
    for n = 1:3
        nome_flair = strcat(dir_registrado,'paciente',int2str(i),'_FLAIR_',int2str(n),'.dcm');
        nome_msk = strcat(dir_root,'paciente',int2str(i),'/mascaras/paciente',int2str(i),'_mask_',int2str(n),'.bmp');
        flair = dicomread(nome_flair);
        
        % itera extracao de cerebro
        disp(strcat('paciente',int2str(i),'_FLAIR_',int2str(n),'.dcm'));
        
        usar_contraste = 1;
        novo_nIter = nIter;
        ok_contraste = true;
        while (ok_contraste)
            ok = true;        
            while(ok)
                try
                    msk = extrai_cerebro(flair,novo_nIter,usar_contraste); % executa algoritmo               
                catch
                    break;
                end
                novo_nIter = input('Novo numero de iteracoes? ');            
                if isempty(novo_nIter) || novo_nIter <= 0
                    ok = false;
                    imwrite(msk,nome_msk,'BMP'); % salva mascara
                end
            end
            resp = input('Tirar correcao de contraste? [s/n] ');
            if resp == 1
                usar_contraste = 0;
            else
                ok_contraste = false;
            end
        end
        close all;
        
    end  
    
end