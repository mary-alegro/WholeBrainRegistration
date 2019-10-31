function [value] = duplicates(vec)
%find duplicated values in a array and return then

U = unique(vec);
H = histc(vec,U);

index = find(H > 1);
value = U(index);

end

