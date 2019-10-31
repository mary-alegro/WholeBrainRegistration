function img2 = segmenta(img, nIter)
    limiar = acha_limiar_cinapce(img); %acha limiar automaticamente
    mask = threshold(img,limiar); %limiariza

    %abertura
    se = strel('disk',12);
    mask = imopen(mask,se); 
    mask = tapa_buracos(mask);

    %snakes
    ok = true;
    figure;
    while(ok)             
        mask2 = region_seg(img, mask, nIter);        

        novo_nIter = input('Novo numero de iteracoes? ');            
        if isempty(novo_nIter) || novo_nIter <= 0
            ok = false;
            close;
        end
        nIter = novo_nIter;
    end
    
    mask = tapa_buracos(mask2);

    img2 = img;
    img2(mask ~= 1) = 0;
