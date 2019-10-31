function flip_histo(case_dir,slices,dim)

%
% Some histo slices appear flipped inside cases
% This function flips te slices in the selected dimension
% CASE_DIR: case full path
% SLICES : array with slice indices
% DIM: dimension to be flipe (Y = 1, X = 2)
%

files = dir(strcat(case_dir,'/*.tif'));
files = sortfiles(files);
nFiles = length(files);

nSlices = length(slices);

for s=1:nSlices
    
    S = slices(s);
    
    %find slice name
    index = -1;
    for i=1:nFiles
        numTmp = fileNumber(files(i).name);
        if numTmp == S
            index = i;
            break;
        end
    end
    
    %file not found
    if index == -1
        fprintf('Slice %d does not exist.\n',S);
        break;
    end
    
    %flip
    name = strcat(case_dir,'/',files(index).name);
    img = imread(name);
    [r c N] = size(img);
    if N > 1 %RGB
        R = img(:,:,1);
        G = img(:,:,2);
        B = img(:,:,3);
        
        if dim == 1 %rows
            R = R(end:-1:1,:);
            G = G(end:-1:1,:);
            B = B(end:-1:1,:);            
            img = cat(3,R,G,B);
        elseif dim == 2 %cols
            R = R(:,end:-1:1); 
            G = G(:,end:-1:1); 
            B = B(:,end:-1:1); 
            img = cat(3,R,G,B)               
        end 
        
        imwrite(img,name);
        
    else %grayscale        
        if dim == 1
            img = img(end:-1:1,:);
        elseif dim == 2
            img = img(:,end:-1:1); 
         end 
        
        imwrite(img,name);            
    end
    
end


end


% % recursivelly searches for the FILE index 
% % FILES must be sorted
% function index = findFileIndex(file, files, aux_index)
%     
%     index = -1;    
%     numFile = fileNumber(file);    
%     nF = length(files);     
%     
%     if nF <= 2
%         numTmp1 = fileNumber(files(1).name);
%         numTmp2 = fileNumber(files(2).name);
%         
%         if numFile == numTmp1
%         
%     else
%         mid = ceil(nF/2);        
%         numTmp = fileNumber(files(mid).name);
%         
%         if numFile == numTmp
%         else
%             
%         end        
%     end
% 
% end



function num = fileNumber(file)

idx1 = strfind(file,'_');
idx2 = strfind(file,'.');

num = file(idx1(end)+1 : idx2(end)-1);
num = str2num(num);

end