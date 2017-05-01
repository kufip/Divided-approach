clear all
close all
clc %clear the Command Window

% filenamekkel majd elszórakozni - output .png.jpg
% beolvasásnál esetleg majd számozásos rákérdezés
funghi = '.\funghi.png';
little_dirty = '.\little_dirty.png';
medium_dirty = '.\medium_dirty.png';
hard_dirty = '.\hard_dirty.png';
meat_digestion = '.\meat_digestion.png';
str_base = '.\input_images';
filetype = '.jpg';

% Reading the image
f = imread(strcat(str_base,funghi));

% Noise reduction with Gaussian kernel
% esetleg majd megnézni parameter-t
f = double(rgb2gray(f));
Gaussian = fspecial('Gaussian');
f = conv2(f,Gaussian);

% Gradient intensity and direction calculation
Prewitt_h = fspecial('Prewitt');
Prewitt_v = [-1 0 1; -1 0 1; -1 0 1];
dx = conv2(f,Prewitt_h); %horizontal derivative image
dy = conv2(f,Prewitt_v); %vertical derivative image
d = hypot(dx,dy); %gradient intensity
theta = atan2d(dx,dy); %edge direction

% Non-maximum suppression
for

%{
a=0;
for n = 1:size(dy,1)
    for m = 1:size(dy,2)
        if theta(n,m) == 90 || theta(n,m) == -90
            a = a+1;
        end
    end
end
%}


% figure(1)
% imshow(uint8(f))

%{
figure(1)
subplot(221)
imshow(uint8(dx))
title('dx')
subplot(223)
imshow(uint8(dxx))
title('dxx')
subplot(222)
imshow(uint8(dy))
title('dy')
subplot(224)
imshow(uint8(dyy))
title('dyy')
%}


% writing out the output image
% output_filename = strcat(funghi,filetype);
% imwrite(output,output_filename);
