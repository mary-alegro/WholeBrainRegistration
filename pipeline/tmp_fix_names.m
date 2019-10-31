function tmp_fix_names

dir1 = '/autofs/space/hercules_001/users/malegro/Brains/Case01/blockface/orig/';
dir2 = '/autofs/space/hercules_001/users/malegro/Brains/Case01/histology/orig/';

ext1 = '*.JPG';
ext2 = '*copy.jpg';

files = dir(strcat(dir1,ext1));
nFiles = length(files);

%blockface
for f=1:nFiles
    name = files(f).name;
    old_name = strcat(dir1,name);
    
    name = lower(name);   
    new_name = name(2:end);    
    new_name = strcat(dir1,new_name);
    
    copyfile(old_name,new_name);
end

files = dir(strcat(dir2,ext2));
nFiles = length(files);

%blockface
for f=1:nFiles
    name = files(f).name;
    old_name = strcat(dir2,name);
    
    name = lower(name);    
    idx1 = strfind(name,' ');
    idx2 = strfind(name,'.');    
    new_name = [name(1:idx1(1)-1) name(idx2(1):end)];    
    new_name = strcat(dir2,new_name);
    
    nError = 0;
    try
        copyfile(old_name,new_name);
        nError = nError + 1;
    catch
        fprintf('There were %d copy errors.\n',nError);
    end
end