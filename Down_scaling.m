clear all
close all
clc
% Canny edge detector
I = imread('D:\ITK\Microfluid\2016_2017_02\Results\image processing\counting\trichinella\Divided approach\input_images\CMF3_E7_7_Trichinella_live_50mlph_4x_v1_eleje.png');
% Ir2 = imresize(I,1/2);
[~, BW,] = Canny_edge_detector_func(I,150,120);
% imwrite(imresize(IrC2,2), 'Rescaled_Canny_0.5.png')
figure, imshow(I), figure, imshow(BW), title('Ir+C 0.5'),

CC = bwconncomp(BW);

BW_largest = bwareafilt(BW,[549 inf]); % felsõ korlát csak az infinity lehet, mert sok képen össze vannak ragadva
figure, imshow(BW_largest)
CC_largest = bwconncomp(BW_largest);

avg_size = 960;
sum_pixel=0;
for n=1:CC_largest.NumObjects
    sum_pixel = sum_pixel + size(CC_largest.PixelIdxList{1,n},1);
end

number_of_parasites = sum_pixel/avg_size;% CC_largest.NumObjects;


% a = CC_largest.NumObjects;

% Hole filler
%{
BW = im2bw(IrC2);
for n=1:size(BW,1) % keret eltávolítása
    for m=1:size(BW,2)
        if n==2 || n==3 || n==4 || n==5 ...
           || n==size(BW,1)-4 || n==size(BW,1)-3 || n==size(BW,1)-2 || n==size(BW,1)-1
             BW(n,m)=0;
        elseif m==2 ||  m==3 || m==4 || m==5 ...
           || m==size(BW,2)-4 || m==size(BW,2)-3 || m==size(BW,2)-2 || m==size(BW,2)-1
             BW(n,m)=0;
        end
    end
end
%{
for n=2:5
    for m=2:size(BW,2)-1
        BW(n,m)=0;
    end
end
for n=size(BW,1)-4:size(BW,1)-1
    for m=2:size(BW,2)-1
        BW(n,m)=0;
    end
end
for m=2:5
    for n=6:size(BW,1)-5
        BW(n,m)=0;
    end
end
for m=size(BW,2)-4:size(BW,2)-1
    for n=6:size(BW,1)-5
        BW(n,m)=0;
    end
end
%}
figure, imshow(BW), % subplot(122), imshow(BW2)
BW_hole = imfill(BW, 'holes');
figure, imshow(BW_hole)
%}

% BW2 = imcomplement(BW);

% Shapes
%{
I = im2bw(imread('.\shapes.png'));
I2 = imfill(I, 'holes');
figure, imshow(I), figure, imshow(I2)
%}
% Coins
%{
% Coins = im2bw(imread('.\coins.jpg'));
% Hole = imfill(Coins);
% figure, imshow(Hole)
%}
% Down scalings diff parameters
%{
Ir3 = imresize(I,3/4);
[~, IrC3] = Canny_edge_detector_func(Ir3,150,120);
imwrite(imresize(IrC3,2), 'Rescaled_Canny_0.75.jpg')
figure, imshow(IrC3), title('Ir+C 0.75')

IrC6 = imresize(I,0.6);
[~, IrC6] = Canny_edge_detector_func(IrC6,150,120);
imwrite(imresize(IrC6,2), 'Rescaled_Canny_0.6.jpg')
figure, imshow(IrC6), title('Ir+C 0.6')

IrC5 = imresize(I,0.55);
[~, IrC5] = Canny_edge_detector_func(IrC5,150,120);
imwrite(imresize(IrC5,2), 'Rescaled_Canny_0.55.jpg')
figure, imshow(IrC5), title('Ir+C 0.55')
%}

% [~,C] = Canny_edge_detector_func(I,150,120);

% CIr = imresize(C,1/2); % eredeti Cannys esett a felére
% figure, imshow(CIr), title('C+Ir 1-->0.5')
% fuse = imfuse(CIr,IrC);
% figure, imshow(fuse)

% IrC2 = imresize(IrC,2);
% figure, imshow(C),title('Original Canny'), figure, imshow(IrC2),title('Ir+C 0.5-->1')

% figure, imshow(I), figure, imshow(I_resize)

