close all
clear all
clc

image = imread('.\funghi.png');
thresh1 = 100;
thresh2 = 80;
Canny = Canny_edge_detector_func(image,thresh1,thresh2);

figure(1)
imshow(Canny)