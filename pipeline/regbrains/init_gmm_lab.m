function [init_obj] = init_gmm_lab(wsize,wp,samples,rfactor)

%
% SAMPLES: samples(i).name = '/home/to/file.ext';
%          samples(i).fore = [x1,y1; x2,y2; x3,y3]; 
%          samples(i).back = [x1,y1; x2,y2; x3,y3]; 
%
%

    nFiles = length(samples);
    
    uL_T = []; uA_T = []; uB_T = [];
    uL_B = []; uA_B = []; uB_B = [];  
    
    
    for s=1:nFiles    
        file = samples(s).name; 
        img = imread(file);
        
        if ~isempty(rfactor)
            img = imresize(img,rfactor);
        end
        
        
        img = weak_wb(img,wp);
%         yiq = rgb2ntsc(img);       
%         I = yiq(:,:,2);
%         Q = yiq(:,:,3); 
        
        % Convert image from RGB colorspace to lab color space.
        cform = makecform('srgb2lab');
        lab_Image = applycform(im2double(img),cform);
        L = lab_Image(:, :, 1); 
        A = lab_Image(:, :, 2); 
        B = lab_Image(:, :, 3); 
    
        % tissue
        points = samples(s).fore;
        rows = size(points,1);
        for p = 1:rows
             mupT = points(p,:);
             ct = sub2ind(size(L),mupT(1), mupT(2));
             wL = getwindow(ct,L,wsize);
             wA = getwindow(ct,A,wsize);  
             wB = getwindow(ct,B,wsize); 
             uL_T = [uL_T; wL(:)];
             uA_T = [uA_T; wA(:)];
             uB_T = [uB_T; wB(:)];
        end           
         % background
        points = samples(s).back;
        rows = size(points,1);
        for p = 1:rows
             mupB = points(p,:);
             ct = sub2ind(size(L),mupB(1), mupB(2));
             wL = getwindow(ct,L,wsize);
             wA = getwindow(ct,A,wsize);  
             wB = getwindow(ct,B,wsize); 
             uL_B = [uL_B; wL(:)];
             uA_B = [uA_B; wA(:)];
             uB_B = [uB_B; wB(:)];
        end       
    end
    
    muT = [mean(uL_T(:)) mean(uA_T(:)) mean(uB_T(:))];
    muB = [mean(uL_B(:)) mean(uA_B(:)) mean(uB_B(:))];
    cLAB = cat(2,uL_T,uA_T,uB_T);
    covarT = cov(cLAB);
    cLAB = cat(2,uL_B,uA_B,uB_B);
    covarB = cov(cLAB);
    
    init_obj.mu = [muT; muB];
    init_obj.Sigma = cat(3,covarT,covarB);
end

