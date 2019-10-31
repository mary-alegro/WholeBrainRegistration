function posprocess_histo_color_2D_old(casedir)

%
% Applies 2D registration transforms to create color image slices.
%
% CASEDIR :  ie /storage/Hisstology/Case01
%

if casedir(end) ~= '/'
    casedir = [casedir '/'];
end    

histo_dir = strcat(casedir,'histology/');
histo_orig_dir = strcat(histo_dir,'orig/');
histo_seg_dir = strcat(histo_dir,'seg/');
transf2d_dir = strcat(histo_dir,'reg1/');
final_dir = strcat(histo_dir,'final/');
color_2d_dir = strcat(final_dir,'2d/');
color_3d_dir = strcat(final_dir,'3d/');
tmp_color_dir = strcat(final_dir,'tmp/');


mkdir(final_dir);
mkdir(color_2d_dir);
mkdir(color_3d_dir);
mkdir(tmp_color_dir);

files = dir(strcat(histo_seg_dir,'*.tif'));
nFiles = length(files);

for f = 1:nFiles %seg file name (.tif)
    orig_file = strcat(histo_orig_dir,changeExt(files(f).name,'jpg'));
    seg_file = strcat(histo_seg_dir,files(f).name);
    transf2d_file = strcat(transf2d_dir,files(f).name,'.lta');
    
    R_file = strcat(tmp_color_dir,'R_',files(f).name);
    G_file = strcat(tmp_color_dir,'G_',files(f).name);
    B_file = strcat(tmp_color_dir,'B_',files(f).name);    
    
    img = imread(orig_file);    
    mask = imread(seg_file); %uses segmented file as mask
    
    %resize color channels to match mask
    %mask to remove backgroung
    img2 = imresize(img,0.15);
    img2 = imresize(img2,0.7630);
    img3 = img2;
    R = img3(:,:,1);
    G = img3(:,:,2);
    B = img3(:,:,3);
    R(mask == 0) = 0;
    G(mask == 0) = 0;
    B(mask == 0) = 0;    
    imwrite(R,R_file,'TIFF');
    imwrite(G,G_file,'TIFF');
    imwrite(B,B_file,'TIFF');
    
    %apply transform to RGB channels    
    R_file_t = strcat(tmp_color_dir,'R_t_',changeExt(files(f).name,'mgz'));
    G_file_t = strcat(tmp_color_dir,'G_t_',changeExt(files(f).name,'mgz'));
    B_file_t = strcat(tmp_color_dir,'B_t_',changeExt(files(f).name,'mgz'));     
    command1 = sprintf('mri_convert -at %s -rt cubic %s %s',transf2d_file, R_file, R_file_t);
    command2 = sprintf('mri_convert -at %s -rt cubic %s %s',transf2d_file, G_file, G_file_t);
    command3 = sprintf('mri_convert -at %s -rt cubic %s %s',transf2d_file, B_file, B_file_t);
    [status1, result] = system(command1);
    [status2, result] = system(command2);
    [status3, result] = system(command3);
    
    if status1 ~= 0 || status2 ~= 0 || status3 ~= 0
        fprintf('### Error appling 2D transform to file %s.\n ###',files(f).name);        
    end
    
    %create color image
    color_file = strcat(color_2d_dir,files(f).name);    
    R2 = MRIread(R_file_t);
    G2 = MRIread(G_file_t);
    B2 = MRIread(B_file_t);
    color_img = cat(3,uint8(R2.vol),uint8(G2.vol),uint8(B2.vol));
    imwrite(color_img,color_file,'TIFF');       
end


end






