function parameter_search(arquivos)

nFiles = length(arquivos);



bestcv = 0;
for log2c = -5:2:15
  for log2g = 3:-2:-15
    
    cv = 0;
    for p=1:nCasos %v-fold  
        n = 1:nCasos;
        n = n(n ~= p);

        dirs = diretorios(n);
       
        dados_treino = reamostra_dados(1000,dirs,'early.mat');
        dados_teste = cria_matriz_ed(diretorios(p),0,0,'early.mat');
        classes_treino = dados_treino(:,end);
        classes_teste = dados_teste(:,end);    

        % faz rescale [0 1] de todos os dados juntos, para mantes range de valores
        % correto no treino e no teste
        [rows cols N] = size(dados_treino);
        dados_tmp = cat(1, dados_treino, dados_teste);
        dados_tmp = rescale2(dados_tmp,0,1);
        dados_treino = dados_tmp(1:rows,:);
        dados_teste = dados_tmp(rows+1:end,:);

        dados_treino(:,end) = classes_treino(:,end);
        dados_teste(:,end) = classes_teste(:,end);

        %as caracteristicas mais relevantes segundo f-score
        %dados_treino = dados_treino(:,[chars end]);
        %dados_teste = dados_teste(:,[chars end]);
      	
        %embaralha matriz de treino
        [rows cols N] = size(dados_treino);    
        [idxRand, c, c2] = rand_int(1,rows,rows,0, 1, 0);
        dados_treino = dados_treino(idxRand,:);
        labels_treino = dados_treino(:,end);
        dados_treino = dados_treino(:,1:end-1);
        labels_teste = dados_teste(:,end);
        dados_teste = dados_teste(:,1:end-1);
        
        cmd = ['-t 2 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];

        %treina SVM
        model = svmtrain(labels_treino,dados_treino,cmd);

        %testa SVM
        [classificacao, precisao, probabilidades] = svmpredict(labels_teste, dados_teste, model);
        cv = cv + precisao(1);
    end
     cv = cv/nCasos; %media da classificacao pra todos os pacientes
    
    if (cv >= bestcv)
          bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
    end
    fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    
  end
end