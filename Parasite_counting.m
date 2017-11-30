function [no_of_parasites,BW_largest] = Parasite_counting(image,t1,t2)
% Counting the parasites based on its average size
    [BW] = Canny_edge_detector_func(image,t1,t2);
    BW_largest = bwareafilt(BW,[549 inf]);
    CC_largest = bwconncomp(BW_largest);
    avg_size = 960; % based on measurements on training set
    sum_pixel=0;
    for n=1:CC_largest.NumObjects
        sum_pixel = sum_pixel + size(CC_largest.PixelIdxList{1,n},1);
    end
no_of_parasites = sum_pixel/avg_size;
