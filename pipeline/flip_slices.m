function [new_volume] = flip_slices(volume, dim)

N = size(volume,3);
new_volume = zeros(size(volume));

for n=1:N
    
    slice = volume(:,:,n);
    
    if dim == 1
        new_volume(:,:,n) = slice(end:-1:1,:);
    elseif dim == 2
        new_volume(:,:,n) = slice(:,end:-1:1);    
    end
    
end




