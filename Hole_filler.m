function [filled_image] = Hole_filler(input_image)
    % Filling every parasite on the images
    BW = im2bw(input_image);
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
filled_image = imfill(BW, 'holes');
