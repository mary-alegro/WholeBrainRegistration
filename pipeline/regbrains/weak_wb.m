function new_img = weak_wb(img,wp)

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

nR = zeros(size(R));
nG = zeros(size(R));
nB = zeros(size(R));

for c = 1:255
    %red
    nC = round((255*c)/wp(1));
    if( nC > 255) 
        nC = 255;
    end
    nR(R == c) = nC;
    
    %green
    nC = round((255*c)/wp(2));
    if( nC > 255) 
        nC = 255;
    end
    nG(G == c) = nC;
    
    %blue
    nC = round((255*c)/wp(3));
    if( nC > 255) 
        nC = 255;
    end
    nB(B == c) = nC;
end

new_img = cat(3,gscale(nR),gscale(nG),gscale(nB));

end

