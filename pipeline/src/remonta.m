function [m] = remonta(n)

m = zeros(64,64);
count = 1;
for r = 1:64:4033
    tmp = n(r:r+63);
    m(count,:) = tmp';
    count = count + 1;
end