function posprocess_intnorm_color_3D(case_dir)

%
% Runs intensity normalization on the already 2D registered color images
% To be used after posprocess_histo_color_2D and before
% posprocess_histo_color_3D
%
% ROOT_DIR: case dir (ie. /Users/jdoe/Brains/Case01)
%

if case_dir(end) ~= '/'
    case_dir = [case_dir '/'];

end

ext = 'tif';

histo_dir = strcat(case_dir,'histology/');
final_dir = strcat(histo_dir,'final/');
color2d_dir = strcat(final_dir,'2d/');
%tmp_dir = strcat(final_dir,'tmp/');


%
%first, split color channels
%
R_prefix = 'R_t_';
G_prefix = 'G_t_';
B_prefix = 'B_t_';

files = dir(strcat(color2d_dir,'*.',ext));
nFiles = length(files);

for f=1:nFiles
    
    rgb_file = strcat(color2d_dir,files(f).name);
    R_file = strcat(color2d_dir,R_prefix,files(f).name);
    G_file = strcat(color2d_dir,G_prefix,files(f).name);
    B_file = strcat(color2d_dir,B_prefix,files(f).name);
    
    rgb_img = imread(rgb_file);
    R_channel = rgb_img(:,:,1);
    G_channel = rgb_img(:,:,2);
    B_channel = rgb_img(:,:,3);
    
    imwrite(R_channel,R_file,'TIFF');
    imwrite(G_channel,G_file,'TIFF');
    imwrite(B_channel,B_file,'TIFF');
    
end


%
%Second, run int. correction on the separate channels
%

red_files = dir(strcat(color2d_dir,R_prefix,'*.',ext));
red_files = sortfiles(red_files);
green_files = dir(strcat(color2d_dir,G_prefix,'*.',ext));
green_files = sortfiles(green_files);
blue_files = dir(strcat(color2d_dir,B_prefix,'*.',ext));
blue_files = sortfiles(blue_files);

nFiles = length(red_files); %arrays must be of the same length

%pick middle slice as the histogram reference (middle brain images usually are pretty "stable")
 ref = round(nFiles/2);
 R_ref_file = strcat(color2d_dir,red_files(ref).name);  
 G_ref_file = strcat(color2d_dir,green_files(ref).name); 
 B_ref_file = strcat(color2d_dir,blue_files(ref).name); 

for f=ref:-1:1    
    
    fprintf('Processing %s.\n',red_files(f).name);

    %Apply transform to red channel                   
    fix_file = strcat(color2d_dir,red_files(f).name);
    new_img_file = strcat(color2d_dir,'intcorr_',red_files(f).name);         
    do_intcorr(fix_file,R_ref_file,new_img_file);
    R_ref_file = new_img_file;
    
    fprintf('Processing %s.\n',green_files(f).name);

    %Apply transform to green channel              
    fix_file = strcat(color2d_dir,green_files(f).name);
    new_img_file = strcat(color2d_dir,'intcorr_',green_files(f).name);         
    do_intcorr(fix_file,G_ref_file,new_img_file);
    G_ref_file = new_img_file;
    
    fprintf('Processing %s.\n',blue_files(f).name);
        
    %Apply transform to blue channel              
    fix_file = strcat(color2d_dir,blue_files(f).name);
    new_img_file = strcat(color2d_dir,'intcorr_',blue_files(f).name);         
    do_intcorr(fix_file,B_ref_file,new_img_file);   
    B_ref_file = new_img_file;  
 
end

%iterates 2nd part of the volumes     
R_ref_file = strcat(color2d_dir,red_files(ref).name);  
G_ref_file = strcat(color2d_dir,green_files(ref).name); 
B_ref_file = strcat(color2d_dir,blue_files(ref).name); 
for f=ref+1:nFiles   
    
    fprintf('Processing %s.\n',red_files(f).name);

    %Apply transform to red channel                   
    fix_file = strcat(color2d_dir,red_files(f).name);
    new_img_file = strcat(color2d_dir,'intcorr_',red_files(f).name);         
    do_intcorr(fix_file,R_ref_file,new_img_file);
    R_ref_file = new_img_file;
    
    fprintf('Processing %s.\n',green_files(f).name);

    %Apply transform to green channel              
    fix_file = strcat(color2d_dir,green_files(f).name);
    new_img_file = strcat(color2d_dir,'intcorr_',green_files(f).name);         
    do_intcorr(fix_file,G_ref_file,new_img_file);
    G_ref_file = new_img_file;
    
    fprintf('Processing %s.\n',blue_files(f).name);
        
    %Apply transform to blue channel              
    fix_file = strcat(color2d_dir,blue_files(f).name);
    new_img_file = strcat(color2d_dir,'intcorr_',blue_files(f).name);         
    do_intcorr(fix_file,B_ref_file,new_img_file);   
    B_ref_file = new_img_file;  
    
end

end


%
% Helper funtions
%

%build mask
function m = build_mask(file)
    m = zeros(size(file));
    m(file >= 1) = 1; 
end

%do intensity correction
function do_intcorr(fix_file,ref_file,new_img_file)
        ref_img = imread(ref_file);        
        fix_img = imread(fix_file);
        mask = build_mask(fix_img);
        [new_img] = intensity_compensation(fix_img,ref_img);         
        new_img(mask == 0) = 0;
                  
        imwrite(new_img,new_img_file);
end

