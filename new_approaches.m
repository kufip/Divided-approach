clear all
close all
clc
load('.\Mats\Saturation mats\sat_bw.mat')

I = imread('.\input_images\CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para3.png');

% for presentation
%{
figure(4)
subplot(121)
imshow(I)
%}

a=5;
b=5;
image_median=I;
for n=1:3
    Ch_i=I(:,:,n);
    Ch_i=medfilt2(Ch_i,[a,b],'symmetric');
    image_median(:,:,n)=Ch_i;
end
I = rgb2gray(image_median);
% level = graythresh(I);
% I_bw = im2bw(I,level);
% stats_1 = regionprops(I_bw, 'Image');


laplacian = fspecial('log');
%{
Prewitt_hor = fspecial('prewitt');
Prewitt_ver = [-1 -1 -1; 0 0 0; 1 1 1];
edge_enhancement = [0 -1 0; -1 5 -1; 0 -1 0];
output_edge_enhancement = conv2(double(I),edge_enhancement);
figure(5)
imshow(output_edge_enhancement)
output_phor = conv2(double(I), Prewitt_hor);
output_pver = conv2(double(I), Prewitt_ver);
%}

output_lap = conv2(double(I), laplacian);


level=graythresh(output_lap);
bw_lap=im2bw(output_lap, level);
CC = bwconncomp(bw_lap);
stats = regionprops(CC, 'Area');


%{
for y = 1:size(bw_lap,1) % y a sor
    for x = 1:size(bw_lap,2) % x az oszlop
        if y < 11
            bw_lap(y,x) = 0;
        end
        if y > 566
            bw_lap(y,x) = 0;
        end
        if x < 150
            bw_lap(y,x) = 0;
        end
        if x > 680
            bw_lap(y,x) = 0;
        end
    end
end
%}
% figure(2)
% imshow(bw_lap)



% bw_boundingbox = regionprops(bw_lap, 'BoundingBox');

% probe with the 
bw_lap_area_filt = bwareafilt(bw_lap, [1000 Inf]); % 500-nál kisebb objektumokat szûrõm ki
% bw_lap_area_filt = bwareafilt(bw_lap_area_filt, [750 1000]);
bw_filled = regionprops(bw_lap_area_filt,'FilledImage');
figure(1)
% subplot(121)
% imshow(bw_lap)
% subplot(122)
imshow(bw_lap_area_filt)
imwrite(bw_lap_area_filt, 'para1_1000.jpg')
% figure(5)
% imshow(bw_filled(1).FilledImage)
% 
% figure(2)
% imshow(bw_lap_area_filt)


fuse = imfuse(bw_lap_area_filt,output_bw,'blend');

% for presentation
%{
figure(3)
subplot(121)
imshow(bw_lap)
subplot(122)
imshow(bw_lap_area_filt)
%}

figure(4)
% for presentation
%{
% subplot(122)
%}
imshow(fuse)


%{
Andrisnak for 2nd screen problem
set(gcf,'Position',[1367 -91 1440 783])
%}


% figure(2)
% imshow(bw_filled)
% figure(3)
% imshow(output_pver)
% figure(4)
% imshow(output_lap)
% figure(5)
% imshow(bw_lap)
%%
% base distraction with feature detection base on SIFT
