function matrix2 = toJavaInteger(matrix)

%
% Creates a java Interger matrix
%

[r c N] = size(matrix);


matrix2 = javaArray('java.lang.Integer',r,c);

%for n=1:N
    for i = 1:r
        for j = 1:c
            matrix2(i,j) = java.lang.Integer(matrix(i,j));
        end
    end
%end


end

