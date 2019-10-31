function select_points(root_dir)

%
% ROOT_DIR : directory with .tif images
%

reg_dir = strcat(root_dir,'/registered/');

if root_dir(end) ~= '/'
    root_dir = [root_dir '/'];
end
    

tmp = dir(reg_dir);
if isempty(tmp)
    mkdir(reg_dir);
end

files = dir(strcat(root_dir,'*.tif'));
files = sortFiles(files);
nFiles = length(files);

mid_idx = round(nFiles/2);
ref_name = strcat(root_dir,files(mid_idx).name);

ref_img = improcess(ref_name);
imwrite(ref_img,strcat(reg_dir,files(mid_idx).name));


[rows cols N] = size(ref_img);

nNeig = 2;
count = 1;
    
for f = (mid_idx-1):-1:1    
%for f = (mid_idx+1):nFiles
    
    fprintf('%s\n',files(f).name);
    
    mov_name = strcat(root_dir,files(f).name);
    mov_img = improcess(mov_name);
    
    [xy_mov xy_ref] = cpselect(mov_img, ref_img,'Wait',true);    
    tform = cp2tform(xy_mov,xy_ref,'lwm',6);
    %tform = cp2tform_mod(xy_mov,xy_ref,'nonreflective similarity noscaling');
    mov_img2 = imtransform(mov_img,tform,'XData',[1 cols],'YData',[1 rows]);  
    
    display_alignment(ref_img,mov_img2);
        
    imwrite(mov_img2,strcat(reg_dir,files(f).name));    
    
    %if count >= nNeig
        ref_img = mov_img2;
    %end    
    %count = count + 1;
end

% ref_img = imread(ref_name);
% for f = (mid_idx+1):1    
%     
%     fprintf('%s\n',files(f).name);
%     
%     mov_name = strcat(root_dir,files(f).name);
%     mov_img = imread(mov_name);
%     
%     [xy_mov xy_ref] = cpselect(mov_img, ref_img,'Wait',true);
%     tform = cp2tform(xy_mov,xy_ref,'nonreflective similarity');
%     %tform = cp2tform_mod(xy_mov,xy_ref,'nonreflective similarity noscaling');
%     mov_img2 = imtransform(mov_img,tform,'Size', [rows  cols]);
%     imwrite(mov_img2,strcat(reg_dir,files(f).name));
%     
%     ref_img = mov_img2;
% end


end


%useful pre processing
function img = improcess(img_name)

    img = imread(img_name);
    img = rgb2gray(img);
    
    mask = img;
    mask(mask ~= 0) = 1;
    
    img = adapthisteq(img);
    img(mask == 0) = 0;
    
    %img = imresize(img,0.5);    
    img = mat2gray(img);
        
    img = straighten(img); 
end



function files = sortFiles(blockfiles)

nFiles = length(blockfiles);

aux = zeros(nFiles,1);

for i=1:nFiles
   str = blockfiles(i).name;
   
   ind1 = strfind(str,'_'); 
   ind1 = ind1(end);   
   ind2 = strfind(str,'.'); 
   ind2 = ind2(end);
   
   num = str2num(str(ind1+1:ind2-1));
   aux(i) = num;
end

[s sidx] = sort(aux);

files = blockfiles(sidx);

end