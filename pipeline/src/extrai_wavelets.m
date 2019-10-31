function [struct] = extrai_wavelets(img_strut, struct)                                   
                                   
 %
 % Extrai dados de textura via wavelets, calculando energia para cada
 % imagens de detalhe 
 % 
 
 janela = 9;
 
 levels = 2;
 
 wavelets = {'db4', 'coif3','sym2','bior5.5'}; 
% wavelets = {'db4', 'db10','db20','coif2','coif3','coif5','sym2','sym8','sym20','bior1.5','bior3.3','bior5.5'};
 
 nWaves = length(wavelets);
 
 countWave = 1;
 
 nErros = 0;
 
 struct = aloca_espaco(struct,wavelets,levels,img_strut); %aloca espaco na estrutura
 
 fprintf('Iniciando calculo das texturas por Wavelets...\n');

 for wi=1:nWaves %itera wavelets
     
     wave = wavelets(wi);
     wave = char(wave);
     
     fprintf('calculando %s\n',wave);
     
     for s=1:3 %itera slices

         mask = img_strut.mask(:,:,s);
         indices = find(mask ~= 0);
         len = length(indices);
         
         img_T1 = img_strut.T1(:,:,s);
         img_T1c = img_strut.T1c(:,:,s);
         img_FLAIR = img_strut.FLAIR(:,:,s);

         for t=1:len %itera pixeis          
             
             % T1               
             try
                w = getwindow(indices(t),img_T1,janela);
             catch
                nErros = nErros+1;
                continue;
             end
             [C,S] = wavedec2(w,levels,wave);
             [Ea,Eh,Ev,Ed] = wenergy2(C,S);
             
             count = countWave;
             
             for l=1:levels
                 struct.mri(1).s(s).wavelets(t,count) = Eh(l);
                 struct.mri(1).s(s).wavelets(t,count+1) = Ev(l);
                 struct.mri(1).s(s).wavelets(t,count+2) = Ed(l);
                 count = count+3;
             end

             % T1c
             try
                w = getwindow(indices(t),img_T1c,janela);
             catch
                nErros = nErros+1;
                continue;
             end
             [C,S] = wavedec2(w,levels,wave);
             [Ea,Eh,Ev,Ed] = wenergy2(C,S);
             
             count = countWave;
             
             for l=1:levels
                 struct.mri(2).s(s).wavelets(t,count) = Eh(l);
                 struct.mri(2).s(s).wavelets(t,count+1) = Ev(l);
                 struct.mri(2).s(s).wavelets(t,count+2) = Ed(l);
                 count = count+3;
             end

             %FLAIR
             try
                w = getwindow(indices(t),img_FLAIR,janela);
             catch
                nErros = nErros+1;
                continue;
             end
             [C,S] = wavedec2(w,levels,wave);
             [Ea,Eh,Ev,Ed] = wenergy2(C,S);
             
             count = countWave;
             
             for l=1:levels
                 struct.mri(3).s(s).wavelets(t,count) = Eh(l);
                 struct.mri(3).s(s).wavelets(t,count+1) = Ev(l);
                 struct.mri(3).s(s).wavelets(t,count+2) = Ed(l);
                 count = count+3;
             end
             
         end

     end
     
     countWave = countWave+3*levels;
     
 end
 
 fprintf('Numero de erros: %d\n',nErros);
 
 
 % aloca espaco na estrutura de dados
 function [struct] = aloca_espaco(struct,wavelets,levels,img_strut) 
     
     nWaves = length(wavelets);
     
     for s=1:3
         mask = img_strut.mask(:,:,s);
         rows = length(find(mask ~= 0));
         cols = nWaves*3*levels;
         
         struct.mri(1).s(s).wavelets = zeros(rows,cols);   
         struct.mri(2).s(s).wavelets = zeros(rows,cols);
         struct.mri(3).s(s).wavelets = zeros(rows,cols);
     end
                    