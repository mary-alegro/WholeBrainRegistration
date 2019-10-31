function [volume,location] = carrega_volume_dicom(diretorio)

% [VOLUME] = CARREGA_VOLUME_DICOM(DIRETORIO)
%
% carrega imagens DICOM e ordena pelo campo SliceLocation do DICOM header
%
% DIRETORIO : diretorio onde estao as imagens

arquivos = dir(diretorio);

[r c N] = size(arquivos);

volume = [];
location = [];


tmp = [];

for i = 1:r
    arq = arquivos(i);
    if ~strcmp(arq.name,'.') && ~strcmp(arq.name,'..')      
        nome = strcat(diretorio,'/',arq.name);
        info = dicominfo(nome);
        
        dados.nome = nome;
        dados.location = info.SliceLocation;
        
        if isempty(tmp)
            tmp = dados;            
        else
            tmp = [tmp; dados];
        end
    end
end

%func comparacao quicksort
g = inline('sign(m(x).location-m(y).location)','m','x','y');

%ordena fatias de acordo com a tag SliceLocation do DICOM
ord = quicksort(tmp,g);

ordenado = tmp(ord);

N = length(ordenado);

for i=1:N
    img = dicomread(ordenado(i).nome);
    loc = ordenado(i).location;
    
    if isempty(volume)
        volume = img;
    else        
        volume = cat(3,volume,img);
    end
    
    if isempty(location)
        location = loc;
    else
        location = cat(1,location,loc);
    end
end
    
volume = double(volume);