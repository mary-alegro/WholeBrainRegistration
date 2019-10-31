function fix_filename(direc)

files = dir(strcat(direc,'/*.tif'));
nFiles = length(files);

for f=1:nFiles
    str = files(f).name;
    idx1 = strfind(str,'_');
    idx2 = strfind(str,'.');
    
    nNums = idx2-idx1-1;
    num = str(idx1+1:idx2-1);
    if nNums < 4
        num = cat(2,'0',num);
        newStr = strcat(str(1:idx1),num,str(idx2:end));
        movefile(strcat(direc,'/',str),strcat(direc,'/',newStr));
    end
end
