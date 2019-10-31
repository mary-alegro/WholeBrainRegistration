function separa_modalidades_rec(diretorio,dir_out)

%
% Separa as imagens por aquisicao
% percorre os diretorios recursivamente
% salva os arquivo em DIR_OUT
% DIRETORIO : path do diretorio que contem os dicom
% DIR_OUT : diretorio onde os arquivos serao salvos
%

nFalhas = 0;
nArqNaoCopiado = 0;
nArqCopiado = 0;

arquivos = dir(diretorio);

result = dir(dir_out);
if isempty(result)
    mkdir(dir_out);
end

for i=1:length(arquivos)
    arquivo = arquivos(i);
    if strcmp(arquivo.name,'.') || strcmp(arquivo.name,'..')
        continue;
    end
    if ~arquivo.isdir 
        nome = strcat(diretorio,'/',arquivo.name);
        try
            info = dicominfo(nome);
            
            protocolName = info.ProtocolName;
            protocolName(protocolName == char(47)) = [];
            seriesDescription = info.SeriesDescription;
            seriesDescription(seriesDescription == char(47)) = [];
            
            %nome_dir = strcat(dir_out,'/',info.AcquisitionDate,'-',protocolName,'-',seriesDescription,'-',int2str(info.SeriesNumber),'_',info.PatientName.FamilyName);
            nome_dir = strcat(dir_out,'/',protocolName,'_',seriesDescription,'_',int2str(info.SeriesNumber));
            
            %indx = find(nome_dir==char(13) | nome_dir==char(10) | nome_dir==' ');
            indx = find(nome_dir==char(13) | nome_dir==char(10));
            nome_dir(indx) = [];

            result = dir(nome_dir);
            
%             fprintf('%s\n',nome_dir);
            
            if isempty(result)
                mkdir(nome_dir);
            end
            
           
            [sucess, m, m2] = copyfile(info.Filename,nome_dir);
            if sucess == 0
                nArqNaoCopiado = nArqNaoCopiado+1;
                fprintf('Nao movido: %s\n',info.Filename);
            else
                nArqCopiado = nArqCopiado + 1;
            end
            
        catch E
            nFalhas = nFalhas+1;
            if(exist('info','var'))
                fprintf('Falha: %s\n',info.Filename);                
            end
        end
    else
        dir2 = strcat(diretorio,'/',arquivo.name);
        separa_modalidades_rec(dir2,dir_out);
    end    
end

fprintf('Numero de Arquivos Copiados: %d \nNumero de Arquivos nao copiados: %d \nNumero de Erros: %d\n', nArqCopiado,nArqNaoCopiado,nFalhas);
