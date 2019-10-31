function [wavemap] = compute_wavelets(img)

janela = 19; 
levels = 2; 
wavelets = {'db4', 'coif3','sym2','bior5.5'}; 
% wavelets = {'db4', 'db10','db20','coif2','coif3','coif5','sym2','sym8','sym20','bior1.5','bior3.3','bior5.5'}; 
nWaves = length(wavelets); 
countWave = 1; 
nErros = 0;
 
len = length(img(:));

wvmap_h = ones(size(img));
wvmap_v = ones(size(img));
wvmap_d = ones(size(img));

    wave = wavelets(1);
    wave = char(wave);

for i = 1:len
    w = getwindow(i,img,janela);
    
    [C,S] = wavedec2(w,levels,wave);
    [Ea,Eh,Ev,Ed] = wenergy2(C,S);
    
    l=1;
    
    wvmap_h(i) = Eh(l);
    wvmap_v(i) = Ev(l);
    wvmap_d(i) = Ed(l);      
    
    
end

end

