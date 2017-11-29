clear all
close all
clc
d_adap = load('.\d_orig.mat');
d = d_adap.d;
I = imread('.\Back_loading.jpg');
% I = rgb2gray(I);
I2 = imfill(I);
figure(1)
subplot(121)
imshow(I)
subplot(122)
imshow(I2)

% level = graythresh(d);
% bw = im2bw(d,level);