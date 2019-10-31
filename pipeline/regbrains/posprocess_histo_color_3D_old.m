function posprocess_histo_color_3D(casedir, regmethod, intnorm)

% 
% Applies the 3D registration transform to the R G B channels in order to create a color
% volume.
%
% CASEDIR : root dir for the case. I.e. /storage/Brains/Case01
% REGMETHOD : 3D registration method.
%             1 : DRAMMS
% INTNORM : Applies interslice intensity correction. 
%           1 : yes 
%           0: no
%


if casedir(end) ~= '/'
    casedir = [casedir '/'];
end    

histo_dir = strcat(casedir,'histology/');
histo2mri_dir = strcat(histo_dir,'intnorm2/volume/');
final_dir = strcat(histo_dir,'final/');
color_3d_dir = strcat(final_dir,'3d/');
tmp_color_dir = strcat(final_dir,'tmp/');

%
% runs intensity correction
%

r_prefix = 'R_t_';
g_prefix = 'G_t_';
b_prefix = 'B_t_';

if intnorm == 1
    
    %file names prefix for reading files
    r_prefix = 'intcorr_R_t_';
    g_prefix = 'intcorr_G_t_';
    b_prefix = 'intcorr_B_t_';
    
    % computes the intensity correction affine transf. params for the red
    % channel and applies the same parameters to the other channels. The
    % red channel is the one presenting the most contrasting differenced among slices.
    
    red_files = dir(strcat(tmp_color_dir,'/R_t_*.mgz'));
    red_files = sortfiles(red_files);
    green_files = dir(strcat(tmp_color_dir,'/G_t_*.mgz'));
    green_files = sortfiles(green_files);
    blue_files = dir(strcat(tmp_color_dir,'/B_t_*.mgz'));
    blue_files = sortfiles(blue_files);
    
    nFiles = length(red_files); %should be the same for all arrays    
    
    ref = round(nFiles/2);   
    R_ref_file = strcat(tmp_color_dir,red_files(ref).name);  
    G_ref_file = strcat(tmp_color_dir,green_files(ref).name); 
    B_ref_file = strcat(tmp_color_dir,blue_files(ref).name); 
    
    %iterates 1st part of the volumes
    for f = ref-1:-1:1           
        %Apply transform to red channel                   
        fix_file = strcat(tmp_color_dir,red_files(f).name);
        new_img_file = strcat(tmp_color_dir,'intcorr_',red_files(f).name);         
        do_intcorr(fix_file,R_ref_file,new_img_file);
        R_ref_file = new_img_file;
        
        %Apply transform to green channel              
        fix_file = strcat(tmp_color_dir,green_files(f).name);
        new_img_file = strcat(tmp_color_dir,'intcorr_',green_files(f).name);         
        do_intcorr(fix_file,G_ref_file,new_img_file);
        G_ref_file = new_img_file;
        
        %Apply transform to blue channel              
        fix_file = strcat(tmp_color_dir,blue_files(f).name);
        new_img_file = strcat(tmp_color_dir,'intcorr_',blue_files(f).name);         
        do_intcorr(fix_file,B_ref_file,new_img_file);   
        B_ref_file = new_img_file;
    end    

    %iterates 2nd part of the volumes     
    R_ref_file = strcat(tmp_color_dir,red_files(ref).name);  
    G_ref_file = strcat(tmp_color_dir,green_files(ref).name); 
    B_ref_file = strcat(tmp_color_dir,blue_files(ref).name); 
    
   for f = ref+1:1:nFiles       
        %Apply transform to red channel                   
        fix_file = strcat(tmp_color_dir,red_files(f).name);
        new_img_file = strcat(tmp_color_dir,'intcorr_',red_files(f).name);         
        do_intcorr(fix_file,R_ref_file,new_img_file);
        R_ref_file = new_img_file;
        
        %Apply transform to green channel              
        fix_file = strcat(tmp_color_dir,green_files(f).name);
        new_img_file = strcat(tmp_color_dir,'intcorr_',green_files(f).name);         
        do_intcorr(fix_file,G_ref_file,new_img_file);
        G_ref_file = new_img_file;
        
        %Apply transform to blue channel              
         fix_file = strcat(tmp_color_dir,blue_files(f).name);
         new_img_file = strcat(tmp_color_dir,'intcorr_',blue_files(f).name);         
         do_intcorr(fix_file,B_ref_file,new_img_file);   
         B_ref_file = new_img_file;            
    end
    
    %
    % </intensity correction>
    %    
    
end

    % path to the final histo 3D volume that is used in the registration
    % process (before registration). 
    % we need to read voxel dimensions from this file
    histo2mri_file = strcat(histo2mri_dir,'histo_volume_manual_reg2.mgz');
    histo2mri = MRIread(histo2mri_file);
    vox2ras0 = histo2mri.vox2ras0; 
    
    red_vol = load_color_mgz_volume(tmp_color_dir,r_prefix);
    red_mgz.vol = red_vol;
    red_mgz.vox2ras0 = vox2ras0;
    red_file = strcat(color_3d_dir,'R_histo_volume.mgz');
    MRIwrite(red_mgz,red_file);
    
    green_vol = load_color_mgz_volume(tmp_color_dir,g_prefix);
    green_mgz.vol = green_vol;
    green_mgz.vox2ras0 = vox2ras0;
    green_file = strcat(color_3d_dir,'G_histo_volume.mgz');
    MRIwrite(green_mgz,green_file);
    
    blue_vol = load_color_mgz_volume(tmp_color_dir,b_prefix);
    blue_mgz.vol = blue_vol;
    blue_mgz.vox2ras0 = vox2ras0;
    blue_file = strcat(color_3d_dir,'B_histo_volume.mgz');
    MRIwrite(blue_mgz,blue_file);


end



%
% Help Functions
%

%load MGZ
function img = load_mgz(name)
    img = MRIread(name);
    img = uint8(round(img.vol));
end

%build mask
function m = build_mask(file)
    m = zeros(size(file));
    m(file >= 1) = 1; 
end

%do intensity correction
function do_intcorr(fix_file,ref_file,new_img_file)
        ref_img = load_mgz(ref_file);        
        fix_img = load_mgz(fix_file);
        mask = build_mask(fix_img);
        [new_img] = intensity_compensation(fix_img,ref_img);         
        new_img(mask == 0) = 0;
        
        mgz.vol = new_img;            
        MRIwrite(mgz,new_img_file);
end


% Apply intensity transform
% function new_img = apply_intcorr(img,T)
% 
% new_img = zeros(size(img));
% 
% % default: 256 bins
% H1 = imhist(img);
% %removes background influence
% H1(1) = 0;
% %map intensities
% n = length(H1);
% %skip fist histogram position so to avoid processing background
% for xi=1:n-1 % image always [0 255]
%     v = F(xi,T);
%     new_img(img == xi) = v;
% end
% new_img = uint8(round(new_img));
% 
% end


% Affine transform f
% function y = F(x,param)
%     y = (x.*param(1)) + param(2);
%     %y = x + param(1);
% end


function volume = load_color_mgz_volume(directory,prefix)

files = dir(strcat(directory,prefix,'*.mgz'));
files = sortfiles(files);
nFiles = length(files);
volume = [];
for f = 1:nFiles   
    img_name = strcat(directory,'/',files(f).name);    
    mgz = MRIread(img_name);
    img = mgz.vol;    
    try
        volume = cat(3, volume,img);
    catch
        fprintf('Erro na image: %s\n',files(f).name);
    end
end




end