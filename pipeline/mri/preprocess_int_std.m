function volume = preprocess_int_std(volume)

    %ref_vol = loadNormRef();
    params = [1 4095 0 0.998];
    lm_type = 'L1';
    
    %ref_vol = gscale(ref_vol);    
    %landmarks = treina_normaliza_mri(params,ref_vol,lm_type);
      
    volume = gscale(volume);
        
    N = size(volume,3);
    mid = floor(N/2);
    ref_vol = cat(3,volume(:,:,mid-1),volume(:,:,mid),volume(:,:,mid+1));
        
    %compute histogram landmarks
    landmarks = treina_normaliza_mri(params,ref_vol,lm_type);

    %run standardization
    volume = normaliza_mri(params,[],volume,lm_type,landmarks);
    volume = gscale(volume);       

end

