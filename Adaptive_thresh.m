function [d] = Adaptive_thresh(intensity,a)
    % F�nyer�ss�gb�l fakad� kis hib�k kik�sz�b�l�s�re
    
    summ = sum(sum(intensity));
    N = size(intensity,1)*size(intensity,2);
    avg = summ/N;
    
    vard = zeros(size(intensity,1),size(intensity,2));
    for n = 3:size(intensity,1)-2 % 3-t�l �gy a feh�r keretet elker�jl�k
        for m = 3:size(intensity,2)-2
            vard(n,m) = ((intensity(n,m)-avg)^2)/N;
        end
    end
    max_var = max(max(vard));
    
    for n = 1:size(vard,1)
        for m = 1:size(vard,2)
            if vard(n,m) < (max_var/a)
                intensity(n,m) = 0;
            else
                intensity(n,m) = intensity(n,m);
            end
        end
    end
d = intensity;