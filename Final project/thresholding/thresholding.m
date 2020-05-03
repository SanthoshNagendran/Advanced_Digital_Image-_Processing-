clear;
clc;
format compact;

% im_org=double(imread('01.bmp'));
% im_org=double(imread('05.bmp'));
% im_org=double(imread('13.bmp'));
 im_org=double(imread('16.bmp'));
% im_org=double(imread('17.bmp'));
% im_org=double(imread('20.bmp'));
% im_org=double(imread('23.bmp'));
% im_org=double(imread('30.bmp'));
% im_org=double(imread('35.bmp'));
% im_org=double(imread('36.bmp'));
% im_org=double(imread('40.bmp'));
size(im_org)

im_pro=im_org-min(im_org(:));
im_pro=round(im_pro*(255/max(im_pro(:))));

subplot(3,3,1);
imagesc(im_pro);colormap(gray);axis image;axis off;
title('original');



sumOfVar=zeros(1,254);
for i=1:255
   % t=i-0.5;
   % Ib=im_pro(im_pro<t);
   % Io=im_pro(im_pro>t);
    %t=i-0.5;
    %Ib=im_pro(im_pro<i);
    %Io=im_pro(im_pro>i);
 %   sumOfVar(i)=var(Ib)+var(Io);
 ni = i;
numrows = size(im_org,1);
numcols = size(im_org,2);
N = 255*ones([numrows numcols], 'uint8');
 Pi = ni./N;
 w1 = sum(Pi);
 w2 = 1 - w1;
 Ia = 1./w1 .* (sum  ((((Pi+1) - Pi).^2)./Pi)   );
 Ib = 1./w2 .* (sum  ((((Pi+1) - Pi).^2)./Pi)   );
 It = (w1 .* Ia) + ((1-w1) .* Ib);
 
 tOpt = angle(max(((w1.*Ia) + ((1-w1).*Ib))));
     %sumOfVar(i)=var(Ib).*numel(Ib)+var(Ia).*numel(Ia);
end


t=find(It==min(It))-1;
imThresh=im_pro;
imThresh(imThresh<mean(t))=0;
imThresh=sign(imThresh);
% 
subplot(3,3,3);
imagesc(imThresh);colormap(gray);axis image;axis off;
title(['FI Measure  ' num2str(t)]);
% 
subplot(3,3,4);
I=im_pro/255;
s=graythresh(I);
x=imbinarize(I,s);
imagesc(x);colormap(gray);axis image;axis off;
title(['Otsu  ' num2str(255*s)]);

x=im_pro;
t=mean(x(:));
x(x<t)=0;
x=sign(x);
subplot(3,3,5);
imagesc(x);colormap(gray);axis image;axis off;
title(['Mean  ' num2str(t)]);

h=zeros(1,256);
for i=0:255
    temp=find(im_pro==i);
    h(i+1)=numel(temp);
end
h=h/sum(h);
% 
entropy=zeros(1,254);
for i=2:255
    x=h(1:i);
    y=h(i:end);
    z=[sum(x) sum(y)];
    entropy(i)=-z*log(z');
end
subplot(3,3,2);
plot(entropy);
title('Entropy');
t=find(entropy==max(entropy));
im_pro(im_pro<t)=0;
im_pro=sign(im_pro);

subplot(3,3,6);
imagesc(im_pro);colormap(gray);axis image;axis off;
title(['Entropy  ' num2str(t)]);

subplot(3,3,7);
imagesc(imThresh);colormap(gray);axis image;axis off;
title(['FI Measure  ' num2str(t)]);
