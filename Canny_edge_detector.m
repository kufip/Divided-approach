clear all
close all
clc %clear the Command Window

d_empty = load('.\Mats\Canny edge detector mats\d_empty.mat'); % mindig egy struct-ot fog bet�lteni,...
% figure(11)
% imshow(uint8(d_empty.d));
% ez�rt d_empty.d-vel tudom megh�vni a d m�trixot benne

% filenamekkel majd elsz�rakozni - output .png.jpg
% beolvas�sn�l esetleg majd sz�moz�sos r�k�rdez�s�l
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
f = imread(strcat(str_base,little_dirty));
%{
figure(1)
imshow(f)
title('Original image')
set(gcf, 'Position', [1367 41 1024 651])
%}

figure(10)
imshow(uint8(f))
% set(gcf,'Position',[-1439 -91 1440 783]) % balra h�zva

% 1. Noise reduction with Gaussian kernel
f = double(rgb2gray(f));
Gaussian = fspecial('Gaussian',5);
f = conv2(f,Gaussian);

% 2. Gradient intensity and direction calculation
Prewitt_h = fspecial('Prewitt');
Prewitt_v = [-1 0 1; -1 0 1; -1 0 1];
dx = conv2(f,Prewitt_h); %horizontal derivative image
dy = conv2(f,Prewitt_v); %vertical derivative image
d = hypot(dx,dy); %gradient intensity
theta = atan2d(dx,dy); %edge direction
save('d_orig.mat','d');
d_orig=d;
figure(1)
imshow(uint8(d))
title('Little dirty before adaptive thresholding')
% set(gcf,'Position',[-1439 -91 1440 783]) % balra h�zva
imwrite(uint8(d),'Para1_after_SIFT.png');

% 3. Adaptive thresholdnig
d = Adaptive_thresh(d,20);
figure(2)
imshow(d)
title('After adaptive thresholding')
% set(gcf,'Position',[-1439 -91 1440 783]) % balra h�zva
% set(gcf,'Position',[1367 -91 1440 783]) % jobbra h�zva
imwrite(uint8(d),'Para1_after_adaptive_thresholding_10.png');
save('d_after_adap.mat','d');
d_adap=d;

% 4. Non-maximum suppression
% sz�lekn�l rendesen kezelve
% theta ir�nyok 6�rai --> -22.5-22.5, 22.5-77.5,...
%{
for n = 1:size(theta,1)
    for m = 1:size(theta,2)
        % f�ls� sor (OK)
        if n == 1
            if m == 1 % bal f�ls� sarok
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
            elseif m == size(theta,2) % jobb f�ls� sarok
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
            else % els� sor �sszes t�bbi eleme
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
        % als� sor (OK)
        elseif n == size(theta,1)
            if m == 1 % bal als� sarok
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
            elseif m == size(theta,2) % jobb als� sarok
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
            else % als� sor �sszes t�bbi eleme
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
        % bal sz�le (OK)
        elseif m == 1
            if 2<n<n-1 % bal f�ls� �s als� sarok m�r kezelve van
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
        % jobb sz�le (OK)
        elseif m == size(theta,2)
            if 2<n<n-1 % jobb f�ls� �s als� sarok m�r kezelve van
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
        else % m�trixon bel�li elemekre, pixelekre
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
% theta ir�nyok 6�rai --> 0-45, 45-90,...
for n = 1:size(theta,1)
    for m = 1:size(theta,2)
        % f�ls� sor (OK)
        if n == 1
            if m == 1 % bal f�ls� sarok
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
            elseif m == size(theta,2) % jobb f�ls� sarok
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
            else % els� sor �sszes t�bbi eleme
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
        % als� sor (OK)
        elseif n == size(theta,1)
            if m == 1 % bal als� sarok
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
            elseif m == size(theta,2) % jobb als� sarok
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
            else % als� sor �sszes t�bbi eleme
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
        % bal sz�le (OK)
        elseif m == 1
            if 2<n<n-1 % bal f�ls� �s als� sarok m�r kezelve van
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
        % jobb sz�le (OK)
        elseif m == size(theta,2)
            if 2<n<n-1 % jobb f�ls� �s als� sarok m�r kezelve van
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
        else % m�trixon bel�li elemekre, pixelekre
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
% theta ir�nyok 6�rai --> -22.5-22.5, + sz�le 0
%{
for n = 1:size(theta,1)
    for m = 1:size(theta,2)
        % f�ls� sor (OK)
        if n == 1
            if m == 1 % bal f�ls� sarok
                d(n,m)=0;
            elseif m == size(theta,2) % jobb f�ls� sarok
                d(n,m)=0;
            else % els� sor �sszes t�bbi eleme
                d(n,m)=0;
            end  
        % als� sor (OK)
        elseif n == size(theta,1)
            if m == 1 % bal als� sarok
                d(n,m)=0;
            elseif m == size(theta,2) % jobb als� sarok
                d(n,m)=0;
            else % als� sor �sszes t�bbi eleme
                d(n,m)=0;
            end
        % bal sz�le (OK)
        elseif m == 1
            if 2<n<n-1 % bal f�ls� �s als� sarok m�r kezelve van
                d(n,m)=0;
            end
        % jobb sz�le (OK)
        elseif m == size(theta,2)
            if 2<n<n-1 % jobb f�ls� �s als� sarok m�r kezelve van
                d(n,m)=0;
            end
        else % m�trixon bel�li elemekre, pixelekre
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
figure(3)
imshow(uint8(d))
title('Non-max suppresssion')
% set(gcf,'Position',[-1439 -91 1440 783]) % balra h�zva
% set(gcf,'Position',[1367 -91 1440 783]) % jobbra h�zva
d_after_non_max_sup = d;
imwrite(uint8(d),'Canny_Non-Maximum_suppression.jpg');
%{
save('d_after_non_max_sup.mat', 'd_after_non_max_sup');
load('.\d_after_non_max_sup.mat')

% Filled image nem z�rta �ssze a sz�tszagatott strukt�r�kat

d_filled = regionprops(d,'FilledImage');

figure(3)
imshow(uint8(d))
title('Non max suppression')
set(gcf, 'Position', [1367 41 1024 651])


%}

% 5. Hysteresis thresholding
% Ford�tott �lkeres�s --> �lkit�lt�s (tomorrow)
t1 = 150; % t1-n�l nagyobb tutira �l
t2 = 120; % t2-n�l kisebb tuti nem �l
for n = 1:size(theta,1)
    for m = 1:size(theta,2)
        if t1<=d(n,m)
            d(n,m)=d(n,m);
        elseif d(n,m)<t2
            d(n,m)=0;
        elseif t2<=d(n,m)<t1 % biztons�g kedv��rt, de elhagy6�
            % f�ls� sor (OK)
            if n == 1
                if m == 1 % bal f�ls� sarok
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                        if t1<=d(n,m+1) % ha legal�bb az egyik szomsz�dja az ir�ny�ban �l, akkor legyen � is az..
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0; % ...m�sk�l�nben ne!
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
                elseif m == size(theta,2) % jobb f�ls� sarok
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
                else % els� sor �sszes t�bbi eleme
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
            % als� sor (OK)
            elseif n == size(theta,1)
                if m == 1 % bal als� sarok
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
                elseif m == size(theta,2) % jobb als� sarok
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
                else % als� sor �sszes t�bbi eleme
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
            % bal sz�le (OK)
            elseif m == 1
                if 2<n<n-1 % bal f�ls� �s als� sarok m�r kezelve van
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
            % jobb sz�le (OK)
            elseif m == size(theta,2)
                if 2<n<n-1 % jobb f�ls� �s als� sarok m�r kezelve van
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
            else % m�trixon bel�li elemekre, pixelekre
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
d_hyst = d;
figure(4)
imshow(d)
title('Hysteresis tresholding')
% set(gcf,'Position',[-1439 -91 1440 783]) % balra h�zva labor monitorra
% set(gcf,'Position',[1367 -91 1440 783]) % jobbra h�zva labor monitorra
% set(gcf, 'Position', [1367 41 1024 651]) % jobbra h�zva otthoni monitorra
imwrite(uint8(d),'Canny_Hysteresis_tresholding.jpg');

% 6. Refulfill the edges - connect its to continous lines
d_back_load = Back_load(d);
figure(5)
imshow(d_back_load)
title('Back loading - connected lines')
imwrite(d_back_load,'Back_loading.jpg');

%{
% Non-max backup
dd = Non_max_backup(d,theta);
figure(6)
imshow(dd)
title('Hysteresis tresholding after non-max backup')
% set(gcf,'Position',[-1439 -91 1440 783]) % balra h�zva
imwrite(dd,'Non-max_backup.jpg');
%}
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
%{
iden = load('.\iden.mat');
figure(7)
imshow(iden.dd);
d_after_adap = load('.\d_after_adap.mat'); % mindig egy struct-ot fog bet�lteni,...
d_orig = load('.\d_orig.mat'); % mindig egy struct-ot fog bet�lteni,...
figure(12)
imshow(imfuse(dd, imread('.\Sat_little_dirty_result.jpg')))
% helping mat
%{
d_500 = load('.\help.mat');
figure(6)
imshow(uint8(d_500.d))
title('T�j�koz�d�')
set(gcf,'Position',[-1439 -91 1440 783]) % balra h�zva
%}
%{
% pr�b�lkoz�sok
% H = vision.Autothresholder;
% BW = step(H,dd);
% BW2 = imfill(BW);
%}
%}