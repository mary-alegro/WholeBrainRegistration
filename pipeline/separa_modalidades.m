function separa_modalidades(diretorio)

nFalhas = 0;
nArqNaoCopiado = 0;
nArqCopiado = 0;

arquivos = dir(diretorio);
for i=1:length(arquivos)
    arquivo = arquivos(i);
    if ~arquivo.isdir 
        nome = strcat(diretorio,'/',arquivo.name);
        try
            info = dicominfo(nome);
            
            protocolName = info.ProtocolName;
            protocolName(protocolName == char(47)) = [];
            seriesDescription = info.SeriesDescription;
            seriesDescription(seriesDescription == char(47)) = [];
            
            nome_dir = strcat(diretorio,'/',info.AcquisitionDate,'-',protocolName,'-',seriesDescription,'-',int2str(info.SeriesNumber),'_',info.PatientName.FamilyName);
            
            indx = find(nome_dir==char(13) | nome_dir==char(10) | nome_dir==' ');
            nome_dir(indx) = [];

            result = dir(nome_dir);
            
%             fprintf('%s\n',nome_dir);
            
            if isempty(result)
                mkdir(nome_dir);
            end
            
            [sucess, m, m2] = movefile(info.Filename,nome_dir);
            if sucess == 0
                nArqNaoCopiado = nArqNaoCopiado+1;
                fprintf('Nao movido: %s\n',info.Filename);
            else
                nArqCopiado = nArqCopiado + 1;
            end
            
        catch
            nFalhas = nFalhas+1;
            fprintf('Falha: %s\n',info.Filename);
        end
    end
end

fprintf('Numero de Arquivos Copiados: %d \nNumero de Arquivos nao copiados: %d \nNumero de Erros: %d\n', nArqCopiado,nArqNaoCopiado,nFalhas);
