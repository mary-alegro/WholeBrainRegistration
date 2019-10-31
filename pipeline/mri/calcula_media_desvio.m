function caracteristicas = calcula_media_desvio

cin(1) = load('/home/maryana/LSI/CINAPCE/imagens/mri/CIN014/dados_hipocampo_GD_9pt.mat');
cin(2) = load('/home/maryana/LSI/CINAPCE/imagens/mri/CIN008/dados_hipocampo_GD_9pt.mat');
cin(3) = load('/home/maryana/LSI/CINAPCE/imagens/mri/CIN011/dados_hipocampo_GD_9pt.mat');
cin(4) = load('/home/maryana/LSI/CINAPCE/imagens/mri/CIN015/dados_hipocampo_GD_9pt.mat');
cin(5) = load('/home/maryana/LSI/CINAPCE/imagens/mri/CIN016/dados_hipocampo_GD_9pt.mat');
cin(6) = load('/home/maryana/LSI/CINAPCE/imagens/mri/CIN017/dados_hipocampo_GD_9pt.mat');
cin(7) = load('/home/maryana/LSI/CINAPCE/imagens/mri/CIN018/dados_hipocampo_GD_9pt.mat');

volumes = {'CIN014','CIN008','CIN011', 'CIN015', 'CIN016', 'CIN017'};

load('nomes.mat');

fprintf('Volume,Característica,Média,Desvio Padrão\n');
for c=7
    ndados = length(cin(c).estrut.dados);  
    media = zeros(1,159);
    dp = zeros(1,159);
    for i=1:ndados
        
        caracteristicas = cat(2,cin(c).estrut.dados(i).ASM,cin(c).estrut.dados(i).contrast,cin(c).estrut.dados(i).correlation,...
            cin(c).estrut.dados(i).variance,cin(c).estrut.dados(i).IDM,cin(c).estrut.dados(i).sum_average,cin(c).estrut.dados(i).sum_variance,...
            cin(c).estrut.dados(i).sum_entropy,cin(c).estrut.dados(i).entropy,cin(c).estrut.dados(i).diff_variance,cin(c).estrut.dados(i).diff_entropy,...
            cin(c).estrut.dados(i).intensity,cin(c).estrut.dados(i).gabor,cin(c).estrut.dados(i).fractal,cin(c).estrut.dados(i).markov.ordem(1).theta,...
            cin(c).estrut.dados(i).markov.ordem(2).theta,cin(c).estrut.dados(i).markov.ordem(3).theta,cin(c).estrut.dados(i).markov.ordem(4).theta,cin(c).estrut.dados(i).markov.ordem(5).theta,...
            cin(c).estrut.dados(i).SRE,cin(c).estrut.dados(i).LRE,cin(c).estrut.dados(i).GLN,cin(c).estrut.dados(i).RLN,...
            cin(c).estrut.dados(i).RP,cin(c).estrut.dados(i).LGRE,cin(c).estrut.dados(i).HGRE,cin(c).estrut.dados(i).SRLGE,...
            cin(c).estrut.dados(i).SRHGE,cin(c).estrut.dados(i).LRLGE,cin(c).estrut.dados(i).LRHGE,cin(c).estrut.dados(i).wavelets);
             
        media = media + mean(caracteristicas);
        dp = dp + std(caracteristicas);
        
        %clear caracteristicas; 
    end  
    media = media./ndados;
    dp = dp./ndados;
    
%     for m=1:length(media)
%         fprintf('%s,%s,%f,%f\n',char(volumes(c)),char(nomes(m)),media(m),dp(m));
%     end
end

clear cin;

