function tmp_changename(root_dir,ext)

if root_dir(end) ~= '/'
    root_dir = [root_dir '/'];
end

files = dir(strcat(root_dir,'*.',ext));
nFiles = length(files);

for i=1:nFiles
    name = files(i).name;
    idx1 = strfind(name,'_');
    idx2 = strfind(name,'_');
    
    num = name(idx1(1)+1:idx2(end)-1);
    num = str2num(num);
    
        prefix = [];
       if (num <= 9)
           prefix = '00';
       elseif (num >= 10 && num <= 99)
           prefix = '0';
       end
    
    newname = strcat(prefix, num2str(num),'.',lower(ext));
 
    copyfile(strcat(root_dir,name),strcat(root_dir,newname));
end


end

