format compact;
clc;

% orgImage = double(imread('lenaC.jpg'));
orgImage = imread('lenaC.jpg');
% orgImage = imread('lena.jpg');

sizeImage = size(orgImage);

r=orgImage(:,:,1);
g=orgImage(:,:,2);
b=orgImage(:,:,3);

newImage=orgImage;
newImage(:,:,1)=r/2;
newImage(:,:,3)=b*2;

newImage(newImage>255)=255;

% imagesc(r);
% colormap(gray);
% axis image;
% axis off;

figure(1);
% x=zeros(256,3);
% x(:,1)=(0:255)'/255;
imagesc(r);colormap(gray);axis image;axis off;
title('R');

figure(2);
% x=zeros(256,3);
% x(:,2)=(0:255)'/255;
imagesc(g);colormap(x);axis image;axis off;
title('G');

figure(3);
% x=zeros(256,3);
% x(:,3)=(0:255)'/255;
imagesc(b);colormap(x);axis image;axis off;
title('B');

figure(4);
imagesc(newImage);axis image;axis off;
title('ORG');
