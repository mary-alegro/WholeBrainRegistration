function [flair t1 t1c] = aplica_mascara(flair, t1, t1c, mascaras)

[rows cols N] = size(mascaras);
    
 
 %FLAIR
 for i = 1:N
     img = flair(:,:,i);
     msk = mascaras(:,:,i);
     img(msk == 0) = 0;
     flair(:,:,i) = img(:,:);
 end
 
 %T1
 for i = 1:N
    img = t1(:,:,i);
    msk = mascaras(:,:,i);
    img(msk == 0) = 0;
    t1(:,:,i) = img(:,:);
 end
 
 %T1c
 for i = 1:N
     img = t1c(:,:,i);
     msk = mascaras(:,:,i);
     img(msk == 0) = 0;
     t1c(:,:,i) = img(:,:);
 end