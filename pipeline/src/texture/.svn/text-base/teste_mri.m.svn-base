function teste_mri

img = dicomread('mri.dcm');
img = gscale(img);


r0 = ones(size(img));
r1 = ones(size(img));
r2 = ones(size(img));
r3 = ones(size(img));
r4 = ones(size(img));
r5 = ones(size(img));
r6 = ones(size(img));
r7 = ones(size(img));
r8 = ones(size(img));
r9 = ones(size(img));
r10 = ones(size(img));
%r11 = ones(size(img));
%r12 = ones(size(img));

        
for r = 5:251
    for c = 5:251
        w = getwindow2(r,c,img,9);
        ccm = graycomatrix(w,'Offset',[0 1],'Symmetric',true);
        %ccm = graycomatrix(w,'Offset',[0 1],'NumLevels',16,'Symmetric',true);
        ccm_n = normalize_ccm(ccm,0,1);
        %ccm_n = ccm;
        
        r0(r,c) = grayccmfeatures(ccm_n,'ASM'); 
        r1(r,c) = grayccmfeatures(ccm_n,'contrast');
        r2(r,c) = grayccmfeatures(ccm_n,'correlation');
        r3(r,c) = grayccmfeatures(ccm_n,'variance');
        r4(r,c) = grayccmfeatures(ccm_n,'IDM');
        r5(r,c) = grayccmfeatures(ccm_n,'sum_average');
        r6(r,c) = grayccmfeatures(ccm_n,'sum_variance');
        r7(r,c) = grayccmfeatures(ccm_n,'sum_entropy');
        r8(r,c) = grayccmfeatures(ccm_n,'entropy');
        r9(r,c) = grayccmfeatures(ccm_n,'diff_variance');
        r10(r,c) = grayccmfeatures(ccm_n,'diff_entropy');
        %r11(r,c) = grayccmfeatures(ccm_n,'IMC1');
        %r12(r,c) = grayccmfeatures(ccm_n,'IMC2');
        
    end
end

imwrite(gscale(r0),'ASM_0.bmp','BMP');
imwrite(gscale(r1),'contrast_0.bmp','BMP');
imwrite(gscale(r2),'correlation_0.bmp','BMP');
imwrite(gscale(r3),'variance_0.bmp','BMP');
imwrite(gscale(r4),'IDM_0.bmp','BMP');
imwrite(gscale(r5),'sum_average_0.bmp','BMP');
imwrite(gscale(r6),'sum_variance_0.bmp','BMP');
imwrite(gscale(r7),'sum_entropy_0.bmp','BMP');
imwrite(gscale(r8),'entropy_0.bmp','BMP');
imwrite(gscale(r9),'diff_variance_0.bmp','BMP');
imwrite(gscale(r10),'diff_entropy_0.bmp','BMP');



        
