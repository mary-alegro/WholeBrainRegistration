im1=imread('ind1_2.jpg');
im11=rgb2gray(im1);
im111=im2double(im11);

[r c N] = size(im111);

w1 = blackman(r);
w2 = w1(:)*w1(:)';

im111 = im111.*w2;


[dx,dy]=gradient(im111);
p1=atan2(dy,dx);
im1111=edge(p1,'canny');
bw1 = bwmorph(im1111,'dilate');
im11111=p1.*bw1;
%subplot(2,1,1);hist(im11111);
im6=hist(im11111(:),512);
im66=fft(im6);


im2=imread('ind2_2.jpg');
im22=rgb2gray(im2);
im222=im2double(im22);
im333=zeros(size(im111));
im333(1:size(im2,1),1:size(im2,2))=im222;
%im333 = im222;

im333 = im333.*w2;


[dx,dy]=gradient(im333);
p2=atan2(dy,dx);
im2222=edge(p2,'canny');
bw2 = bwmorph(im2222,'dilate');
im22222=p2.*bw2;
%subplot(2,1,2);hist(im22222);
im7=hist(im22222(:),512);
im77=conj(fft(im7));
im8=real(ifft(im66.*im77));
im8(1)=0;
plot(im8);
[y,x]=max(im8);
rel_deg=((x*(2*pi/512))*180)/pi;

if rel_deg>180;
    new_rel_deg=rel_deg-180
else
    new_rel_deg=rel_deg
end