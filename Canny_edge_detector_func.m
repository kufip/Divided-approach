function [d] = Canny_edge_detector_func(image,thresh1,thresh2)

    % initiation problems
    if nargin~=3 % control the no. of inputs
        error('Too many or not enough input parameter!');
    end
    if size(image,3)==1 % if it's not colourful
        error('Please, give a colourful image!')
    end
    if thresh1<0  || thresh2<0 % control the threshold values
        error('Please, give a non negative treshold value(s)!')
    elseif thresh1==0 || thresh2==0
        warning('Threshold value(s) = 0!') 
    end
    
    % 1. Resizing images
    f = imresize(image,0.5);
    
    % 2. Noise reduction with Gaussian kernel
    f = double(rgb2gray(f));
    Gaussian = fspecial('Gaussian',5);
    f = conv2(f,Gaussian);
    
    % 3. Gradient intensity and direction calculation
    Prewitt_h = fspecial('Prewitt');
    Prewitt_v = [-1 0 1; -1 0 1; -1 0 1];
    dx = conv2(f,Prewitt_h); %horizontal derivative image
    dy = conv2(f,Prewitt_v); %vertical derivative image
    d = hypot(dx,dy); %gradient intensity
    theta = atan2d(dx,dy); %edge direction
    
    % 4. Adaptive thresholdnig
    d = Adaptive_thresh(d,20); %eliminate device structure
    
    % 5. Non-maximum suppression
    for n = 1:size(theta,1)
        for m = 1:size(theta,2)
            % f�ls� sor (OK)
            if n == 1
                if m == 1 % bal f�ls� sarok
                    if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                        if d(n,m+1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135  % 1.
                        if d(n+1,m)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 45<theta(n,m)<=90 || -135<theta(n,m)<=-90 % 2.
                        if d(n+1,m+1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                elseif m == size(theta,2) % jobb f�ls� sarok
                    if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                        if d(n,m-1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 135<theta(n,m)<=180 || -45<theta(n,m)<=0 % 3.
                        if d(n+1,m-1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135 % 1.
                        if d(n+1,m)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                else % els� sor �sszes t�bbi eleme
                    if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 %1.
                        if d(n+1,m)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                        if d(n+1,m+1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 %4.
                        if d(n,m-1)<d(n,m) && d(n,m+1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 %3.
                        if d(n+1,m-1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                end  
            % als� sor (OK)
            elseif n == size(theta,1)
                if m == 1 % bal als� sarok
                    if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                        if d(n,m+1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135  % 1.
                        if d(n-1,m)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 135<theta(n,m)<=180 || -45<theta(n,m)<=0 % 3.
                        if d(n-1,m+1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end  
                elseif m == size(theta,2) % jobb als� sarok
                    if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                        if d(n,m-1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                        if d(n-1,m-1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135 % 1.
                        if d(n-1,m)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end   
                else % als� sor �sszes t�bbi eleme
                    if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 %1.
                        if d(n-1,m)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                        if d(n-1,m-1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 %4.
                        if d(n,m-1)<d(n,m) && d(n,m+1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 %3.
                        if d(n-1,m+1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                end
            % bal sz�le (OK)
            elseif m == 1
                if 2<n<n-1 % bal f�ls� �s als� sarok m�r kezelve van
                    if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135 % 1. 
                        if d(n-1,m)<d(n,m) && d(n+1,m)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 45<theta(n,m)<=90 || -135<theta(n,m)<=-90 % 2.
                        if d(n+1,m+1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                        if d(n,m+1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 135<theta(n,m)<=180 || -45<theta(n,m)<=0 % 3.
                        if d(n-1,m+1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                end
            % jobb sz�le (OK)
            elseif m == size(theta,2)
                if 2<n<n-1 % jobb f�ls� �s als� sarok m�r kezelve van
                    if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135 % 1.
                        if d(n-1,m)<d(n,m) && d(n+1,m)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 45<theta(n,m)<=90 || -135<theta(n,m)<=-90 % 2.
                        if d(n-1,m-1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45 % 4.
                        if d(n,m-1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    if 135<theta(n,m)<=180 || -45<theta(n,m)<=0 % 3.
                        if d(n+1,m-1)<d(n,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                end
            else % m�trixon bel�li elemekre, pixelekre
                % 1. edge direction
                if 0<theta(n,m)<=45 || -180<=theta(n,m)<=-135
                    if d(n-1,m)<d(n,m) || d(n+1,m)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                % 2. edge direction
                if 45<theta(n,m)<=90 || -135<theta(n,m)<=-90
                    if d(n-1,m-1)<d(n,m) || d(n+1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                % 4. edge direction
                if 90<theta(n,m)<=135 || -90<theta(n,m)<=-45
                    if d(n,m-1)<d(n,m) || d(n,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
                % 3. edge direction
                if 135<theta(n,m)<=180 || -45<theta(n,m)<=0
                    if d(n+1,m-1)<d(n,m) || d(n-1,m+1)<d(n,m)
                        d(n,m)=d(n,m);
                    else
                        d(n,m)=0;
                    end
                end
            end 
        end
    end

    % 6. Hysteresis thresholding
    t1 = thresh1;
    t2 = thresh2;
    for n = 1:size(theta,1)
        for m = 1:size(theta,2)
            if t1<=d(n,m)
                d(n,m)=d(n,m);
            elseif d(n,m)<t2
                d(n,m)=0;
            elseif t2<=d(n,m)<t1 % biztons�g kedv��rt, de elhagy6�
                % f�ls� sor (OK)
                if n == 1
                    if m == 1 % bal f�ls� sarok
                        if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                            if t1<=d(n,m+1) % ha legal�bb az egyik szomsz�dja az ir�ny�ban �l, akkor legyen � is az..
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0; % ...m�sk�l�nben ne!
                            end
                        end
                        if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5  % 1.
                            if t1<=d(n+1,m)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 % 2.
                            if t1<=d(n+1,m+1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                    elseif m == size(theta,2) % jobb f�ls� sarok
                        if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                            if t1<=d(n,m-1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                            if t1<=d(n+1,m-1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1.
                            if t1<=d(n+1,m)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                    else % els� sor �sszes t�bbi eleme
                        if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 %1.
                            if t1<=d(n+1,m)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                            if t1<=d(n+1,m+1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 %4.
                            if t1<=d(n,m-1) || t1<=d(n,m+1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 %3.
                            if t1<=d(n+1,m-1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                    end  
                % als� sor (OK)
                elseif n == size(theta,1)
                    if m == 1 % bal als� sarok
                        if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                            if t1<=d(n,m+1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5  % 1.
                            if t1<=d(n-1,m)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                            if t1<=d(n-1,m+1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end  
                    elseif m == size(theta,2) % jobb als� sarok
                        if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                            if t1<=d(n,m-1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                            if t1<=d(n-1,m-1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1.
                            if t1<=d(n-1,m)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end   
                    else % als� sor �sszes t�bbi eleme
                        if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 %1.
                            if t1<=d(n-1,m)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 %2.
                            if t1<=d(n-1,m-1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 %4.
                            if t1<=d(n,m-1) || t1<=d(n,m+1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 %3.
                            if t1<=d(n-1,m+1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                    end
                % bal sz�le (OK)
                elseif m == 1
                    if 2<n<n-1 % bal f�ls� �s als� sarok m�r kezelve van
                        if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1. 
                            if t1<=d(n-1,m) || t1<=d(n+1,m)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 % 2.
                            if t1<=d(n+1,m+1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                            if t1<=d(n,m+1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                            if t1<=d(n-1,m+1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                    end
                % jobb sz�le (OK)
                elseif m == size(theta,2)
                    if 2<n<n-1 % jobb f�ls� �s als� sarok m�r kezelve van
                        if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5 % 1.
                            if t1<=d(n-1,m) || t1<=d(n+1,m)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5 % 2.
                            if t1<=d(n-1,m-1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5 % 4.
                            if t1<=d(n,m-1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                        if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5 % 3.
                            if t1<=d(n+1,m-1)
                                d(n,m)=d(n,m);
                            else
                                d(n,m)=0;
                            end
                        end
                    end
                else % m�trixon bel�li elemekre, pixelekre
                    % 1. edge direction
                    if -22.5<theta(n,m)<=22.5 || 157.5<theta(n,m)<=180 || -180<=theta(n,m)<=-157.5
                        if t1<=d(n-1,m) || t1<=d(n+1,m)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    % 2. edge direction
                    if 22.5<theta(n,m)<=77.5 || -157.5<theta(n,m)<=-112.5
                        if t1<=d(n-1,m-1) || t1<=d(n+1,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    % 4. edge direction
                    if 77.5<theta(n,m)<=122.5 || -112.5<theta(n,m)<=-67.5
                        if t1<=d(n,m-1) || t1<=d(n,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                    % 3. edge direction
                    if 122.5<theta(n,m)<=157.5 || -67.5<theta(n,m)<=-22.5
                        if t1<=d(n+1,m-1) || t1<=d(n-1,m+1)
                            d(n,m)=d(n,m);
                        else
                            d(n,m)=0;
                        end
                    end
                end 
            end
        end
    end
    
    % 7. Refilling the edges - connect its to continous lines
    d = Back_load(d);
    
    % 8. Hole filler
    d = Hole_filler(d);
end
