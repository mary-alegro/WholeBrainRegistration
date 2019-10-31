global moving;
global fixed;
global path;

file_mr = '/home/medvis1/lzollei/med_volumes/breast/sylvia/breastGe2.vf';
file_grad = '/home/medvis1/lzollei/med_volumes/breast/sylvia/breast2.vf';
mri = readVf(file_mr);
grad = readVf(file_grad);

start_vec  =  [20 20 (pi/16)];

[x, fval, exitflag, output] = fminsearch('objective', start_vec);

output
mesh(path(:, 1), path(:, 2), path(:, 3), path(:, 4));


