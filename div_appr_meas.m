function [ratio] = div_appr_meas(sat_result,Canny_result)
    % COMPUTING THE SIGNIFICANT IMGAGE ELEMENTS RATIO
    % count: az összes megtalált releváns pixel
    
    % Combination of two result & computing the ratio
    sat_result = reshape(sat_result,size(Canny_result,1),size(Canny_result,2));
    count = 0;
    for n = 1:size(Canny_result,1)
        for m = 1:size(Canny_result,2)
            if Canny_result(n,m) > 0 || sat_result(n,m) == 1
                count = count+1;
            end
        end
    end
    all_pixel = size(Canny_result,1)*size(Canny_result,2);
ratio = count/all_pixel;

    