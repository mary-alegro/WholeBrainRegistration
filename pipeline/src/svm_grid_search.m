function [c g] = svm_grid_search(labels,treino,percent)

% [C G] = SVM_GRID_SEARCH(LABELS,TREINO)
%  LABELS: vetor de classes usado no treino
%  TREINO: vetor de caracteristicas usado no treino
%  C : melhor parametro C encontrado
%  G : melhor parametro GAMMA encontrado 
%
%  Realiza "grid search" para localiza melhor par de parametros (C,G)
%  cross-validation padrao de 5-fold

step = 0.25;

l1 = min(labels);
l2 = max(labels);

minimos = find(labels == l1);
maximos = find(labels == l2);

len = length(minimos);

nInd = floor(len * percent);

indices_min = indices_uniformes(1,len,nInd);
indices_max = indices_uniformes(1,len,nInd);

minimos = minimos(indices_min);
maximos = maximos(indices_max);

treino1 = treino(minimos,:);
treino2 = treino(maximos,:);

labels1 = labels(minimos);
labels2 = labels(maximos);

treino = cat(1,treino1,treino2);
labels = cat(1,labels1,labels2);

bestcv = 0;

fprintf('Iniciando grid-search.\n');
for log2c = -1:3
    for log2g = -4:1
        cmd = ['-v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(labels, treino, cmd);
        if (cv >= bestcv),
            bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
        end
        fprintf('%g %g %g (best c=%g, best g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end

%refina busca na regiao dos valores encontrados
fprintf('Refinando valores (best c=%g, best g=%g).\n',bestc, bestg);
bestcv = 0;
for log2c = bestc-2:step:bestc+2
    for log2g = bestg-2:step:bestg+2
        cmd = ['-v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(labels, treino, cmd);
        if (cv >= bestcv),
            bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
        end
        fprintf('%g %g %g (best c=%g, best g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end

c = bestc;
g = bestg;