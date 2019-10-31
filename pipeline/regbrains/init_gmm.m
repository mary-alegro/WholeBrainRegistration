function [init_obj] = init_gmm(wsize,wp,samples,rfactor)

%
% SAMPLES: samples(i).name = '/home/to/file.ext';
%          samples(i).fore = [x1,y1; x2,y2; x3,y3]; 
%          samples(i).back = [x1,y1; x2,y2; x3,y3]; 
%
%

    nFiles = length(samples);
    
    uI_T = []; uQ_T = [];
    uI_B = []; uQ_B = [];    
    
    for s=1:nFiles    
        file = samples(s).name; 
        img = imread(file);
        
        if ~isempty(rfactor)
            img = imresize(img,rfactor);
        end
        
        
        img = weak_wb(img,wp);
        yiq = rgb2ntsc(img);       
        I = yiq(:,:,2);
        Q = yiq(:,:,3);        
    
        % tissue
        points = samples(s).fore;
        rows = size(points,1);
        for p = 1:rows
             mupT = points(p,:);
             ct = sub2ind(size(I),mupT(1), mupT(2));
             wI = getwindow(ct,I,wsize);
             wQ = getwindow(ct,Q,wsize);     
             uI_T = [uI_T; wI(:)];
             uQ_T = [uQ_T; wQ(:)];
        end           
         % background
        points = samples(s).back;
        rows = size(points,1);
        for p = 1:rows
             mupB = points(p,:);
             ct = sub2ind(size(I),mupB(1), mupB(2));
             wI = getwindow(ct,I,wsize);
             wQ = getwindow(ct,Q,wsize);     
             uI_B = [uI_B; wI(:)];
             uQ_B = [uQ_B; wQ(:)];
        end       
    end
    
    muT = [mean(uI_T(:)) mean(uQ_T(:))];
    muB = [mean(uI_B(:)) mean(uQ_B(:))];
    cIQ = cat(2,uI_T,uQ_T);
    covarT = cov(cIQ);
    cIQ = cat(2,uI_B,uQ_B);
    covarB = cov(cIQ);
    
    init_obj.mu = [muT; muB];
    init_obj.Sigma = cat(3,covarT,covarB);
end

