format compact;
clc;

orgImage = double(imread('05.bmp'));

meanImage=orgImage;
medianImage=orgImage;
tol=[0.02 0.001];

for n=2:5
    tmp=medianImage;
    tic
    for k=1:100000
        x=tmp;
        x=[x(n+1:-1:2,:);x;x(end-1:-1:end-n,:)];
        x=[x(:,n+1:-1:2) x x(:,end-1:-1:end-n)];
        for i=n+1:size(x,1)-n
            for j=n+1:size(x,2)-n
                y=x(i-n:i+n,j-n:j+n);
                x(i,j)=median(y(:));
            end
        end
        y=x(n+1:end-n,n+1:end-n);
        z=abs(y-tmp);
        z=z./max(max(y,255-y),max(tmp,255-tmp));
        if max(z(:))<tol(1)
            break;
        end
        tmp=y;
    end
    toc
    tmp=tmp-min(tmp(:));
    tmp=tmp/max(tmp(:));
    subplot(2,3,n);
    imagesc(tmp);colormap(gray);axis image;axis off;
    title(num2str([n k]));
end

subplot(2,3,1);
imagesc(orgImage);colormap(gray);axis image;axis off;
title('Org');
