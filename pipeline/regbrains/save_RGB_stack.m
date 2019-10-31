function save_RGB_stack(R_file,G_file,B_file,dest_dir)

if dest_dir(end) ~= '/'
    dest_dir = [dest_dir '/'];
end

R_vol = MRIread(R_file);
G_vol = MRIread(G_file);
B_vol = MRIread(B_file);

[r c N] = size(R_vol.vol);

%N = 261;

for S = 1:N
    R = round(R_vol.vol(:,:,S)); 
    G = round(G_vol.vol(:,:,S)); 
    B = round(B_vol.vol(:,:,S));
    color = cat(3,R,G,B);
    
    rgb_name = strcat(dest_dir,'histo_RGB_',int2str(S),'.tif');
    
    imwrite(uint8(color),rgb_name,'TIFF');    
end