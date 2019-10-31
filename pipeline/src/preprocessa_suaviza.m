function preprocessa_suaviza

%
% aplica difusao anisotropica nas imagens e faz resize
%

num_iter = 10;
delta_t = 1/7;
kappa = 15;
option = 2;

dir_root = '/home/nex/LSI/Mestrado/implementacao/teste_T1/';


for i = 0:10
    
    if i == 10
        num_iter = 4; %set do paciente10 so usa 4 iteracoes
    end
    
    dir_dcm = strcat(dir_root,'paciente',int2str(i),'/dcm/');
    dir_suavizado = strcat(dir_root,'paciente',int2str(i),'/suavizado/');
    
    arquivos = dir(dir_dcm);
    [r c N] = size(arquivos);
    for n = 1:r
        
        arq = arquivos(n);
        
        if ~strcmp(arq.name,'.') && ~strcmp(arq.name,'..') 
            img = dicomread(strcat(dir_dcm,arq.name));
            
            disp(arq.name);
            
            img = anisodiff2D(img, num_iter, delta_t, kappa, option); %suaviza ruido
            
            [rows cols] = size(img);
            
            if rows >= 512
                img = imresize(img,0.5); %faz rescale da imagem
            end
            
            dicomwrite(uint16(img),strcat(dir_suavizado,arq.name));            
        end        
    end     
end