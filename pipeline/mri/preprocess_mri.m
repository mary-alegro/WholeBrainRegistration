function preprocess_mri(dir_list)
%
% Runs preprocessing steps for the hippocampus MRI
% DIR_LIST : full-path directory for cases data (array of cells)
% (i.e. dir_list(1) = {'/home/malegro/cases/CIN036'})
%

nCases = length(dir_list);

nu_corrected = '_nu_correct.mgz';
back_seg = '_back_seg.mgz';
int_std = '_int_std.mgz';
roi_seg = '_roi_seg.mgz';

doSTEP1 = 0;
doSTEP2 = 0;
doSTEP3 = 1;
doSTEP4 = 0;


%--------------------------
% STEP 1: N3 corrections
%--------------------------

%TODO: call bash command here

%----------------------------------
% STEP 2: background segmentation
%----------------------------------

if doSTEP2

    for c=1:nCases

        directory = dir_list{c};
        idx = strfind(directory,'/');
        case_id = directory(idx(end)+1:end);   

        fprintf('\nSTEP 2: Background segmentation.\n');

        name = strcat(case_id,nu_corrected);
        fullpath = strcat(directory,'/',name);
        mgz = MRIread(fullpath);
        volume = mgz.vol;

        %do standardization
        volume = preprocess_seg_back(volume);
        mgz.vol = volume;

        newname = strcat(case_id,back_seg);
        new_fullpath = strcat(directory,'/',newname);
        MRIwrite(mgz,new_fullpath);

    end

end

%------------------------------------
% STEP 3: intensity standardization
%------------------------------------

% if doSTEP3
%     
%     ref_vol = loadNormRef();
%     params = [1 4095 0 0.998];
%     lm_type = 'L1';
%     
%     ref_vol = gscale(ref_vol);
%     
%     landmarks = treina_normaliza_mri(params,ref_vol,lm_type);
% 
%     for c=1:nCases
% 
%         directory = dir_list{c};
%         idx = strfind(directory,'/');
%         case_id = directory(idx(end)+1:end);   
% 
%         fprintf('\nSTEP 2: Intensity standardization.\n');
% 
%         name = strcat(case_id,back_seg);
%         fullpath = strcat(directory,'/',name);
%         mgz = MRIread(fullpath);
%         volume = mgz.vol;
%         
%         volume = gscale(volume);
% 
%         %run standardizatoin
%         %volume = preprocess_int_std(volume,landmarks, lm_type,params);
%         volume = normaliza_mri(params,[],volume,lm_type,landmarks);
%         new_mgz.vol = gscale(volume);   
%         %new_mgz.vol = volume;
% 
%         newname = strcat(case_id,int_std);
%         new_fullpath = strcat(directory,'/',newname);
%         MRIwrite(new_mgz,new_fullpath);
%     end
% 
% end

if doSTEP3
    
    %ref_vol = loadNormRef();
    params = [1 4095 0 0.998];
    lm_type = 'L1';
    
    %ref_vol = gscale(ref_vol);    
    %landmarks = treina_normaliza_mri(params,ref_vol,lm_type);

    for c=1:nCases

        directory = dir_list{c};
        idx = strfind(directory,'/');
        case_id = directory(idx(end)+1:end);   

        fprintf('\nSTEP 2: Intensity standardization.\n');

        name = strcat(case_id,back_seg);
        fullpath = strcat(directory,'/',name);
        mgz = MRIread(fullpath);
        volume = mgz.vol;        
        volume = gscale(volume);
        
        N = size(volume,3);
        mid = floor(N/2);
        ref_vol = cat(3,volume(:,:,mid-5),volume(:,:,mid),volume(:,:,mid+5));
        
        %compute histogram landmarks
        landmarks = treina_normaliza_mri(params,ref_vol,lm_type);

        %run standardization
        %volume = preprocess_int_std(volume,landmarks, lm_type,params);
        volume = normaliza_mri(params,[],volume,lm_type,landmarks);
        mgz.vol = gscale(volume);   
        
        %new_mgz.vol = volume;

        newname = strcat(case_id,int_std);
        new_fullpath = strcat(directory,'/',newname);
        MRIwrite(mgz,new_fullpath);
    end

end



%------------------------------
% STEP 4: ROI segmentation
%------------------------------



end


% function vol = loadNormRef()
% 
% mgz1 = MRIread('/autofs/space/hercules_001/users/malegro/mri_axial/CIN046/CIN046_back_seg.mgz');
% mgz2 = MRIread('/autofs/space/hercules_001/users/malegro/mri_axial/CIN024/CIN024_back_seg.mgz');
% mgz3 = MRIread('/autofs/space/hercules_001/users/malegro/mri_axial/CIN058/CIN058_back_seg.mgz');
% 
% vol = cat(3, mgz1.vol(:,:,45),mgz2.vol(:,:,45),mgz3.vol(:,:,45));
% %vol = mgz1.vol(:,:,45);
% 
% end





