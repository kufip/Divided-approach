function [d_off] = Base_distraction(d)
    % indeed a SIFT algorithm
    % Removing the base structure
    % improvment: frame beolvasást itt megoldani
    
    % Reading the initial frame
%     init_frame
    base = load('.\Mats\Canny edge detector mats\d_base.mat');
    % Distraction
d_off = minus(d,base.d_base);
