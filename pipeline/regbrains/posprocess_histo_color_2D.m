function posprocess_histo_color_2D(casedir, rratio)

%
% Applies 2D registration transforms to create color image slices.
%
% CASEDIR :  ie /storage/Histology/Case01
% RRATIO:  resize ratio (returned by preprocess_set_colorsize(...))
%

if casedir(end) ~= '/'
    casedir = [casedir '/'];
end    

histo_dir = strcat(casedir,'histology/');
bf_dir = strcat(casedir,'blockface/');
bf_seg_dir = strcat(bf_dir,'seg/');
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
log_transf = [];

for f = 1:nFiles %seg file name (.tif)
    orig_file = strcat(histo_orig_dir,changeExt(files(f).name,'jpg'));
    seg_file = strcat(histo_seg_dir,files(f).name);
    name = files(f).name;
    
    %deformation field files
    mrr2d_file = strcat(transf2d_dir,files(f).name,'.lta');
    idx = strfind(name,'.tif');
    ants_prefix = strcat(transf2d_dir,'ants_',name(1:idx-1)); 

    %tranf log file
    log_file = strcat(transf2d_dir,files(f).name,'.log');
    
    R_file = strcat(tmp_color_dir,'R_',files(f).name);
    G_file = strcat(tmp_color_dir,'G_',files(f).name);
    B_file = strcat(tmp_color_dir,'B_',files(f).name);    
    
    img = imread(orig_file);    
    mask = imread(seg_file); %uses segmented histology image as mask
    
    %resize color channels to match mask
    %mask to remove backgroung
    img2 = imresize(img,0.15);
    img3 = imresize(img2,rratio);
    %img3 = img2;
    R = img3(:,:,1);
    G = img3(:,:,2);
    B = img3(:,:,3);
    R(mask == 0) = 0;
    G(mask == 0) = 0;
    B(mask == 0) = 0;    
    imwrite(R,R_file,'TIFF');
    imwrite(G,G_file,'TIFF');
    imwrite(B,B_file,'TIFF');
    
    %RGB registered filenames
    R_file_t = strcat(tmp_color_dir,'R_t_',changeExt(files(f).name,'nii.gz'));
    G_file_t = strcat(tmp_color_dir,'G_t_',changeExt(files(f).name,'nii.gz'));
    B_file_t = strcat(tmp_color_dir,'B_t_',changeExt(files(f).name,'nii.gz')); 
    
    %apply transforms to RGB channels    
    log_transf = textread(log_file); %read log to find out which registrations were performed
    if isempty(log_transf) || log_transf == 0
        log_transf = 10;
    end
    
    if log_transf == 10 || log_transf == 11 %apply MRI robust register transform
    
        command1 = sprintf('mri_convert -at %s -rt cubic %s %s',mrr2d_file, R_file, R_file_t);
        command2 = sprintf('mri_convert -at %s -rt cubic %s %s',mrr2d_file, G_file, G_file_t);
        command3 = sprintf('mri_convert -at %s -rt cubic %s %s',mrr2d_file, B_file, B_file_t);
        [status1, result] = system(command1);
        [status2, result] = system(command2);
        [status3, result] = system(command3);

        if status1 ~= 0 || status2 ~= 0 || status3 ~= 0
            fprintf('### Error appling 2D MRR transform to file %s.\n ###',files(f).name);  
            continue;
        end
    
    end
    
    if log_transf == 01 || log_transf == 11% has ANTs transform so, apply it
        
        R_file_t2 = strcat(tmp_color_dir,'ants_R_t_',changeExt(files(f).name,'nii.gz'));
        G_file_t2 = strcat(tmp_color_dir,'ants_G_t_',changeExt(files(f).name,'nii.gz'));
        B_file_t2 = strcat(tmp_color_dir,'ants_B_t_',changeExt(files(f).name,'nii.gz')); 
        
        bf_img = strcat(bf_seg_dir,name); %because ANTs requires the reference image in order to apply the deformation
        
        command1 = sprintf('antsApplyTransforms -d 2 -i %s -r %s -n linear -t %s1Warp.nii.gz -t %s0GenericAffine.mat -o %s',...
            R_file_t,bf_img,ants_prefix,ants_prefix,R_file_t2);
        command2 = sprintf('antsApplyTransforms -d 2 -i %s -r %s -n linear -t %s1Warp.nii.gz -t %s0GenericAffine.mat -o %s',...
            G_file_t,bf_img,ants_prefix,ants_prefix,G_file_t2);
        command3 = sprintf('antsApplyTransforms -d 2 -i %s -r %s -n linear -t %s1Warp.nii.gz -t %s0GenericAffine.mat -o %s',...
            B_file_t,bf_img,ants_prefix,ants_prefix,B_file_t2);
        
        [status1, result] = system(command1);
        [status2, result] = system(command2);
        [status3, result] = system(command3);

        if status1 ~= 0 || status2 ~= 0 || status3 ~= 0
            fprintf('### Error appling 2D ANTs transform to file %s.\n ###',files(f).name);    
            continue;
        end
        
        R_file_t = R_file_t2;
        G_file_t = G_file_t2;
        B_file_t = B_file_t2;
        
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






