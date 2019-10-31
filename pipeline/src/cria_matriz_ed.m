function cria_matriz_ed

% CRIA_MATRIZ_ED
%
% edita a estrutura de dados de textura para criar uma matriz, para cada slice, contendo todas as texturas concatenadas
% em colunas
%

dir_root = '/home/maryana/LSI/Mestrado/implementacao/';

for p=0:10    
    
    paciente = strcat('paciente',int2str(p));
    nome_dados = strcat(dir_root,paciente,'/',paciente,'_data.mat');
    saida = strcat(dir_root,paciente,'/',paciente,'_data.mat');
    
    fprintf('processando %s\n',paciente);
    
    dados = load(nome_dados);    
    
    for s = 1:3   
        matriz = [];
        
        for mod = 1:3
            
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).intensity);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).ASM);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).contrast);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).correlation);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).variance);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).IDM);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).sum_average);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).sum_variance);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).sum_entropy);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).entropy);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).diff_variance);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).diff_entropy);
            
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).SRE);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).LRE);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).GLN);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).RLN);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).RP);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).LGRE);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).HGRE);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).SRLGE);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).SRHGE);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).LRLGE);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).LRHGE);
            
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).wavelets);
            
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).fractal); 
            
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).markov.ordem(1).theta);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).markov.ordem(2).theta);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).markov.ordem(3).theta);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).markov.ordem(4).theta);
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).markov.ordem(5).theta);
            
            matriz = cat(2,matriz,dados.struct.mri(mod).s(s).gabor);
        end  
        
        dados.struct.dados(s).valores = matriz;            
        clear matriz;
    end 
    
    fprintf('salvando\n');
     
     struct = dados.struct;
     save(char(saida),'struct'); 
     clear struct;
     clear dados;
end


