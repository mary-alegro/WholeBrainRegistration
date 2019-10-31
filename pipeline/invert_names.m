function invert_names(case_dir,blocks)

%
% Some images were photographed in inverse order whithin some cases.
% CASE_DIR : full path for segmented images in CASE
% B : vector of block(s) whose images were inverted
%


%files = dir(strcat(seg_dir,'*.tif'));
%nBlocks = numBlocks(files);

bkp_dir = strcat(case_dir,'/bkp');
mkdir(bkp_dir);

for b = blocks
    blockFiles = dir(strcat(case_dir,'/*BL',num2str(b),'*.tif'));
    blockFiles = sortfiles(blockFiles);
    nBF = length(blockFiles);
    nBF2 = floor(nBF/2);
    
    ecount = nBF;
    for f=1:nBF2
        name1 = blockFiles(f).name;
        full_name1 = strcat(case_dir,'/',name1);
        idx1 = strfind(name1,'_');
        idx2 = strfind(name1,'.');        
        num_name1 = name1(idx1(end)+1 : idx2(1)-1);        
        
        name2 = blockFiles(ecount).name;
        full_name2 = strcat(case_dir,'/',name2);
        idx3 = strfind(name2,'_');
        idx4 = strfind(name2,'.');        
        num_name2 = name2(idx3(end)+1 : idx4(1)-1);           
        
        new_name1 = strcat(case_dir,'/',name1(1:idx1(end)), num_name2,'.tif');
        new_name2 = strcat(case_dir,'/',name2(1:idx3(end)), num_name1,'.tif');       
        
        ecount = ecount - 1;        
        
        try
            copyfile(full_name1,new_name1);            
            copyfile(full_name2,new_name2);
            
            movefile(full_name1,strcat(bkp_dir,'/',name1));
            movefile(full_name2,strcat(bkp_dir,'/',name2));
        catch
            fprintf('Error copying files.\n');
        end        
    end    
end
