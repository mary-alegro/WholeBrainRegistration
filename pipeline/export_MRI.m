function export_MRI(dir_root,dir_out)

files = dir(dir_root);
nFiles = length(files);

for f=1:nFiles
    file = files(f);
    if strcmp(file.name,'.') || strcmp(file.name,'..')
        continue;
    end
    
    if file.isdir
        direc = strcat(dir_root,'/',file.name);      
        dir_dest = strcat(dir_out,'/',file.name);
        
        fprintf('\n\nExporting from %s.\n',direc);
        separa_modalidades_rec(direc,dir_dest)
    end
end
