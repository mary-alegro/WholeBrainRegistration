function thresh_mri_cori(file,outdir,T,plane)

%
% FILE: .nii or .mgz MRI volume fullpath
% OUTDIR: dir to place binary files
% T: threshold value 
% PLANE: image plane where the masks were segmented
%

if outdir(end) ~= '/'
    outdir = [outdir '/'];
end

fprintf('Loading MRI volume...\n');
vol = MRIread(file);

[rows cols N] = size(vol.vol);

fprintf('Processing image plane...\n');
if plane == 3 %plano sagital da RM
    for s=1:N  
        %img = gscale(volume(:,:,s));
        img = vol.vol(:,:,s);
        img = procslice(img,T);
        
        filename = strcat(outdir,'mri_',num2str(s),'.tif');
        imwrite(img,filename,'TIFF');  
    end
end

if plane == 2 %plano coronal da RM
    for s=1:cols  
        %img = gscale(volume(:,s,:));
        img = vol.vol(:,s,:);
        img = squeeze(img);
        mask = procslice(img,T);
        mask = reshape(mask,rows,1,N);
       
        filename = strcat(outdir,'mri_',num2str(s),'.tif');
        imwrite(mask,filename,'TIFF');  
    end
end

if plane == 1 %plano axial da RM
    for s=1:rows  
        %img = gscale(volume(s,:,:));
        img = vol.vol(s,:,:);
        img = squeeze(img);
        mask = procslice(img,T);
        mask = reshape(mask,1,cols,N);

        filename = strcat(outdir,'mri_',num2str(s),'.tif');
        imwrite(mask,filename,'TIFF');  
    end
end

end

 
%
% limiariza mascara
%
function mask2 = procslice(img,t)
    mask = img;
    mask(mask < t) = 0;
    mask(mask >= t) = 255;
    mask2 = imfill(mask,'hole');
end



