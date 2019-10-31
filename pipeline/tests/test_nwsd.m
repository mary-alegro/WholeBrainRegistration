function nwsd = test_nwsd(dir1,dir2)

if dir1(end) ~= '/'
    dir1 = [dir1 '/'];
end

if dir2(end) ~= '/'
    dir2 = [dir2 '/'];
end

files1 = dir(strcat(dir1,'*.tif'));
files2 = dir(strcat(dir2,'*.tif'));

nFiles1 = length(files1);
nFiles2 = length(files2);

if nFiles1 ~= nFiles2
    error('Different number of files found. Aborting!\n');
end

nwsd = zeros(1,nFiles1);

files1 = sortfiles(files1);
files2 = sortfiles(files2);

fprintf('Running nWSD test...\n');

%compute nWSD

errors = nwsd;
for f = 1:nFiles1
    
    fprintf('%d of %d\n', f, nFiles1);
    
    img1 = imread(strcat(dir1,files1(f).name));
    img2 = imread(strcat(dir2,files2(f).name));
    
    img1b = im2bw(img1);
    img2b = im2bw(img2);
    
    try
        nwsd(f) = WESD(img1b, img2b, 'num', 100, 'norm_type', 2, 'element_spacing', [0.33 0.33]);
        %fprintf('nSWD: %d \n', nwsd(f));
    catch
        fprintf('Error: %d \n', f);
        errors(f) = 1;
    end
    
end

plot(nwsd,'b+');

fprintf('\n Num. errors: %d', sum(errors));


end

