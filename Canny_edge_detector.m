clear all
close all
clc %clear the Command Window

d_empty = load('.\Mats\Canny edge detector mats\d_empty.mat'); % mindig egy struct-ot fog betölteni,...
% ezért d_empty.d-vel tudom meghívni a d mátrixot benne

% filenamekkel majd elszórakozni - output .png.jpg
% beolvasásnál esetleg majd számozásos rákérdezés
sample_0 = '.\sample_2.png';
sample_1 = '.\sample_3.png';
funghi = '.\funghi.png';
little_dirty = '.\little_dirty.png';
medium_dirty = '.\medium_dirty.png';
hard_dirty = '.\hard_dirty.png';
meat_digestion = '.\meat_digestion.png';
empty_structure = '.\CMF3_E7_7_Trichinella_live_50mlph_4x_v1_eleje.png';
para1 = '.\CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
para3 = '.\CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para3.png';
para6 = '.\CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para6.png';
para9 = '.\CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para9.png';
str_base = '.\input_images';
filetype = '.jpg';

% 0. Reading the image
f = imread(strcat(str_base,medium_dirty));
%{
figure(1)
imshow(f)
title('Original image')
set(gcf, 'Position', [1367 41 1024 651])
%}

% 1. Noise reduction with Gaussian kernel
f = double(rgb2gray(f));
Gaussian = fspecial('Gaussian',5);
f = conv2(f,Gaussian);
%{
figure(1)
imshow(uint8(f))
imwrite(uint8(f),'little_dirty_Gaussian.jpg')
%}


% 2. Gradient intensity and direction calculation
Prewitt_h = fspecial('Prewitt');
Prewitt_v = [-1 0 1; -1 0 1; -1 0 1];
dx = conv2(f,Prewitt_h); %horizontal derivative image
dy = conv2(f,Prewitt_v); %vertical derivative image
d = hypot(dx,dy); %gradient intensity
theta = atan2d(dx,dy); %edge direction

figure(1)
imshow(uint8(d))
title('Before adaptive thresholding')
set(gcf,'Position',[1367 -91 1440 783])
% imwrite(uint8(d),'Before_variance_window.png');
%{
d_base = d;
save('d_base.mat', 'd_base')
dd = load('.\Mats\Canny edge detector mats\d_base.mat');

figure(2)
imshow(uint8(d))
title('Gradient intensity')
set(gcf, 'Position', [1367 41 1024 651])

ddd = minus(d,dd.d_base);
%}
%{
% imwrite(uint8(d),'Canny_Gradient_intensity.jpg');
% figure(10)
% imshow(uint8(d))
%}

d = Adaptive_thresholding(d,20);
figure(2)
imshow(uint8(d))
title('After adaptive thresholding')
set(gcf,'Position',[1367 -91 1440 783])
imwrite(uint8(d),'After_variance_window.png');



% 3. Non-maximum suppression
% széleknél rendesen kezelve
% theta irányok 6árai --> -22.5-22.5, 22.5-77.5,...
%{
for n = 1:size(theta,1)
    for m = 1:size(theta,2)
        % fölsõ sor (OK)
        if n == 1
            if m == 1 % bal fölsõ sarok
                if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                    if d(n,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5  % 1.
                    if d(n+1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 % 2.
                    if d(n+1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            elseif m == size(theta,2) % jobb fölsõ sarok
                if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                    if d(n,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                    if d(n+1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1.
                    if d(n+1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            else % elsõ sor összes többi eleme
                if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 %1.
                    if d(n+1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                    if d(n+1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 %4.
                    if d(n,m-1)<d(n,m) && d(n,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 %3.
                    if d(n+1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            end  
        % alsó sor (OK)
        elseif n == size(theta,1)
            if m == 1 % bal alsó sarok
                if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                    if d(n,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5  % 1.
                    if d(n-1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                    if d(n-1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end  
            elseif m == size(theta,2) % jobb alsó sarok
                if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                    if d(n,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                    if d(n-1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1.
                    if d(n-1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end   
            else % alsó sor összes többi eleme
                if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 %1.
                    if d(n-1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                    if d(n-1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 %4.
                    if d(n,m-1)<d(n,m) && d(n,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 %3.
                    if d(n-1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            end
        % bal széle (OK)
        elseif m == 1
            if 2<n<n-1 % bal fölsõ és alsó sarok már kezelve van
                if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1. 
                    if d(n-1,m)<d(n,m) && d(n+1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 % 2.
                    if d(n+1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                    if d(n,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                    if d(n-1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            end
        % jobb széle (OK)
        elseif m == size(theta,2)
            if 2<n<n-1 % jobb fölsõ és alsó sarok már kezelve van
                if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1.
                    if d(n-1,m)<d(n,m) && d(n+1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 % 2.
                    if d(n-1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                    if d(n,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                    if d(n+1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            end
        else % mátrixon belüli elemekre, pixelekre
            % 1. edge direction
            if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5
                if d(n-1,m)<d(n,m) && d(n+1,m)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
            % 2. edge direction
            if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5
                if d(n-1,m-1)<d(n,m) && d(n+1,m+1)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
            % 4. edge direction
            if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5
                if d(n,m-1)<d(n,m) && d(n,m+1)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
            % 3. edge direction
            if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5
                if d(n+1,m-1)<d(n,m) && d(n-1,m+1)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
        end 
    end
end
%}
% theta irányok 6árai --> 0-45, 45-90,...
for n = 1:size(theta,1)
    for m = 1:size(theta,2)
        % fölsõ sor (OK)
        if n == 1
            if m == 1 % bal fölsõ sarok
                if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                    if d(n,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135  % 1.
                    if d(n+1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 45<theta(n,m)<=90 || -135<theta(n,m)<=-90 % 2.
                    if d(n+1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            elseif m == size(theta,2) % jobb fölsõ sarok
                if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                    if d(n,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 135<theta(n,m)<=180 || -45<theta(n,m)<=0 % 3.
                    if d(n+1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135 % 1.
                    if d(n+1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            else % elsõ sor összes többi eleme
                if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 %1.
                    if d(n+1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                    if d(n+1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 %4.
                    if d(n,m-1)<d(n,m) && d(n,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 %3.
                    if d(n+1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            end  
        % alsó sor (OK)
        elseif n == size(theta,1)
            if m == 1 % bal alsó sarok
                if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                    if d(n,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135  % 1.
                    if d(n-1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 135<theta(n,m)<=180 || -45<theta(n,m)<=0 % 3.
                    if d(n-1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end  
            elseif m == size(theta,2) % jobb alsó sarok
                if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                    if d(n,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                    if d(n-1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135 % 1.
                    if d(n-1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end   
            else % alsó sor összes többi eleme
                if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 %1.
                    if d(n-1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                    if d(n-1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 %4.
                    if d(n,m-1)<d(n,m) && d(n,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 %3.
                    if d(n-1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            end
        % bal széle (OK)
        elseif m == 1
            if 2<n<n-1 % bal fölsõ és alsó sarok már kezelve van
                if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135 % 1. 
                    if d(n-1,m)<d(n,m) && d(n+1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 45<theta(n,m)<=90 || -135<theta(n,m)<=-90 % 2.
                    if d(n+1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                    if d(n,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 135<theta(n,m)<=180 || -45<theta(n,m)<=0 % 3.
                    if d(n-1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            end
        % jobb széle (OK)
        elseif m == size(theta,2)
            if 2<n<n-1 % jobb fölsõ és alsó sarok már kezelve van
                if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135 % 1.
                    if d(n-1,m)<d(n,m) && d(n+1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 45<theta(n,m)<=90 || -135<theta(n,m)<=-90 % 2.
                    if d(n-1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                    if d(n,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                if 135<theta(n,m)<=180 || -45<theta(n,m)<=0 % 3.
                    if d(n+1,m-1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            end
        else % mátrixon belüli elemekre, pixelekre
            % 1. edge direction
            if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135
                if d(n-1,m)<d(n,m) || d(n+1,m)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
            % 2. edge direction
            if 45<theta(n,m)<=90 || -135<theta(n,m)<=-90
                if d(n-1,m-1)<d(n,m) || d(n+1,m+1)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
            % 4. edge direction
            if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45
                if d(n,m-1)<d(n,m) || d(n,m+1)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
            % 3. edge direction
            if 135<theta(n,m)<=180 || -45<theta(n,m)<=0
                if d(n+1,m-1)<d(n,m) || d(n-1,m+1)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
        end 
    end
end
figure(3)
imshow(uint8(d))
title('Non-max suppresssion')
set(gcf,'Position',[1367 -91 1440 783])
% széleknél 0-ra veszem
%{
for n = 1:size(theta,1)
    for m = 1:size(theta,2)
        % fölsõ sor (OK)
        if n == 1
            if m == 1 % bal fölsõ sarok
                d(n,m)=0;
            elseif m == size(theta,2) % jobb fölsõ sarok
                d(n,m)=0;
            else % elsõ sor összes többi eleme
                d(n,m)=0;
            end  
        % alsó sor (OK)
        elseif n == size(theta,1)
            if m == 1 % bal alsó sarok
                d(n,m)=0;
            elseif m == size(theta,2) % jobb alsó sarok
                d(n,m)=0;
            else % alsó sor összes többi eleme
                d(n,m)=0;
            end
        % bal széle (OK)
        elseif m == 1
            if 2<n<n-1 % bal fölsõ és alsó sarok már kezelve van
                d(n,m)=0;
            end
        % jobb széle (OK)
        elseif m == size(theta,2)
            if 2<n<n-1 % jobb fölsõ és alsó sarok már kezelve van
                d(n,m)=0;
            end
        else % mátrixon belüli elemekre, pixelekre
            % 1. edge direction
            if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5
                if d(n-1,m)<d(n,m) && d(n+1,m)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
            % 2. edge direction
            if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5
                if d(n-1,m-1)<d(n,m) && d(n+1,m+1)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
            % 4. edge direction
            if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5
                if d(n,m-1)<d(n,m) && d(n,m+1)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
            % 3. edge direction
            if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5
                if d(n+1,m-1)<d(n,m) && d(n-1,m+1)<d(n,m)
                    d(n,m)=d(n,m);
                else
                    d(n,m)=0;
                end
            end
        end 
    end
end
%}
%{
d_after_non_max_sup = d;
save('d_after_non_max_sup.mat, 'd_after_non_max_sup')
load('d_after_non_max_sup.mat')

% Filled image nem zárta össze a szétszagatott struktúrákat

d_filled = regionprops(d,'FilledImage');

figure(3)
imshow(uint8(d))
title('Non max suppression')
set(gcf, 'Position', [1367 41 1024 651])

imwrite(uint8(d),'Canny_Non-Maximum_suppression.jpg');
%}

% 4. Hysteresis thresholding
% Fordított élkeresés --> élkitöltés (tomorrow)
t1 = 120; % t1-nél nagyobb tutira él
t2 = 80; % t2-nél kisebb tuti nem él
for n = 1:size(theta,1)
    for m = 1:size(theta,2)
        if t1<=d(n,m)
            d(n,m)=d(n,m);
        elseif d(n,m)<t2
            d(n,m)=0;
        elseif t2<=d(n,m)<t1 % biztonság kedvéért, de elhagy6ó
            % fölsõ sor (OK)
            if n == 1
                if m == 1 % bal fölsõ sarok
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                        if t1<=d(n,m+1) % ha legalább az egyik szomszédja az irányában él, akkor legyen õ is az..
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0; % ...máskülönben ne!
                        end
                    end
                    if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5  % 1.
                        if t1<=d(n+1,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 % 2.
                        if t1<=d(n+1,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                elseif m == size(theta,2) % jobb fölsõ sarok
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                        if t1<=d(n,m-1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                        if t1<=d(n+1,m-1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1.
                        if t1<=d(n+1,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                else % elsõ sor összes többi eleme
                    if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 %1.
                        if t1<=d(n+1,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                        if t1<=d(n+1,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 %4.
                        if t1<=d(n,m-1) || t1<=d(n,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 %3.
                        if t1<=d(n+1,m-1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                end  
            % alsó sor (OK)
            elseif n == size(theta,1)
                if m == 1 % bal alsó sarok
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                        if t1<=d(n,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5  % 1.
                        if t1<=d(n-1,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                        if t1<=d(n-1,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end  
                elseif m == size(theta,2) % jobb alsó sarok
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                        if t1<=d(n,m-1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                        if t1<=d(n-1,m-1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1.
                        if t1<=d(n-1,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end   
                else % alsó sor összes többi eleme
                    if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 %1.
                        if t1<=d(n-1,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                        if t1<=d(n-1,m-1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 %4.
                        if t1<=d(n,m-1) || t1<=d(n,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 %3.
                        if t1<=d(n-1,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                end
            % bal széle (OK)
            elseif m == 1
                if 2<n<n-1 % bal fölsõ és alsó sarok már kezelve van
                    if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1. 
                        if t1<=d(n-1,m) || t1<=d(n+1,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 % 2.
                        if t1<=d(n+1,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                        if t1<=d(n,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                        if t1<=d(n-1,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                end
            % jobb széle (OK)
            elseif m == size(theta,2)
                if 2<n<n-1 % jobb fölsõ és alsó sarok már kezelve van
                    if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1.
                        if t1<=d(n-1,m) || t1<=d(n+1,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 % 2.
                        if t1<=d(n-1,m-1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                        if t1<=d(n,m-1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                        if t1<=d(n+1,m-1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                end
            else % mátrixon belüli elemekre, pixelekre
                % 1. edge direction
                if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5
                    if t1<=d(n-1,m) || t1<=d(n+1,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                % 2. edge direction
                if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5
                    if t1<=d(n-1,m-1) || t1<=d(n+1,m+1)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                % 4. edge direction
                if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5
                    if t1<=d(n,m-1) || t1<=d(n,m+1)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                % 3. edge direction
                if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5
                    if t1<=d(n+1,m-1) || t1<=d(n-1,m+1)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            end 
        end
    end
end
figure(4)
imshow(uint8(d))
title('Hysteresis tresholding')
set(gcf,'Position',[1367 -91 1440 783]) % labor monitorra
% set(gcf, 'Position', [1367 41 1024 651]) % otthoni monitorra

imwrite(uint8(d),'Canny_Hysteresis_tresholding.jpg');

%{
save('d_empty.mat','d')

theta = atan2d(dy,dx); %edge direction
dd = d;
figure(4)
imshow(imfuse(dd,d,'blend'))
set(gcf,'Position',[1367 -91 1440 783])

figure(5)
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

writing out the output image
output_filename = strcat(funghi,filetype);
imwrite(uint8(d),'d.png');
%}