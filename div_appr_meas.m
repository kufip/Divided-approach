function [ratio] = div_appr_meas(bw2)
 % COMPUTING THE SIGNIFICANT IMGAGE ELEMENTS RATIO
 count = 0;
    for n = 1:size(bw2,1)
        for m = 1:size(bw2,2)
            if (bw2(n,m) == 1)
                count = count+1;
            end
        end
    end
    all_pixel = size(bw2,1)*size(bw2,2);
ratio = count/all_pixel;

    