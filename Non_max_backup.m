function [d_new] = Non_max_backup(d_prev,theta)
    % Refill the blank part of the parasite edges
    
    d_new = zeros(size(d_prev,1),size(d_prev,2));
    for n = 5:size(theta,1)-4
        for m = 5:size(theta,2)-4
            if d_prev(n,m)>0 % fehér pixelekbõl indulunk ki
                d_new(n,m)=d_prev(n,m);
                % 1. edge direction
                if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135
                    if d_prev(n-1,m)<d_prev(n,m)
                        d_new(n-1,m)=d_prev(n,m);
                    elseif d_prev(n+1,m)<d_prev(n,m)
                        d_new(n+1,m)=d_prev(n,m);
                    elseif d_prev(n-1,m)<d_prev(n,m) && d_prev(n+1,m)<d_prev(n,m)
                        d_new(n-1,m)=d_prev(n,m);
                        d_new(n+1,m)=d_prev(n,m);
                    else
                        d_new(n-1,m)=d_prev(n-1,m);
                        d_new(n+1,m)=d_prev(n+1,m);
                    end
                end
                % 2. edge direction
                if 45<theta(n,m)<=90 || -135<theta(n,m)<=-90
                    if d_prev(n-1,m-1)<d_prev(n,m)
                        d_new(n-1,m-1)=d_prev(n,m);
                    elseif d_prev(n+1,m+1)<d_prev(n,m)
                        d_new(n+1,m+1)=d_prev(n,m);
                    elseif d_prev(n-1,m-1)<d_prev(n,m) && d_prev(n+1,m+1)<d_prev(n,m)
                        d_new(n-1,m-1)=d_prev(n,m);
                        d_new(n+1,m+1)=d_prev(n,m);
                    else
                        d_new(n-1,m-1)=d_prev(n-1,m-1);
                        d_new(n+1,m+1)=d_prev(n+1,m+1);
                    end
                end
                % 4. edge direction
                if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45
                    if d_prev(n,m-1)<d_prev(n,m)
                        d_new(n,m-1)=d_prev(n,m);
                    elseif d_prev(n,m+1)<d_prev(n,m)
                        d_new(n,m+1)=d_prev(n,m);
                    elseif d_prev(n,m-1)<d_prev(n,m) && d_prev(n,m+1)<d_prev(n,m)
                        d_new(n,m-1)=d_prev(n,m);
                        d_new(n,m+1)=d_prev(n,m);
                    else
                        d_new(n,m-1)=d_prev(n,m-1);
                        d_new(n,m+1)=d_prev(n,m+1);
                    end
                end
                % 3. edge direction
                if 135<theta(n,m)<=180 || -45<theta(n,m)<=0
                    if d_prev(n+1,m-1)<d_prev(n,m)
                        d_new(n+1,m-1)=d_prev(n,m);
                    elseif d_prev(n-1,m+1)<d_prev(n,m)
                        d_new(n-1,m+1)=d_prev(n,m);
                    elseif d_prev(n+1,m-1)<d_prev(n,m) && d_prev(n-1,m+1)<d_prev(n,m)
                        d_new(n+1,m-1)=d_prev(n,m);
                        d_new(n-1,m+1)=d_prev(n,m);
                    else
                        d_new(n+1,m-1)=d_prev(n+1,m-1);
                        d_new(n-1,m+1)=d_prev(n-1,m+1);
                    end
                end
            end
        end 
    end
end
