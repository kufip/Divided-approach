function [intensity] = histogram(img_matrix)
    % histogram viewer
    
    % bemenetek számának ellenõrzése
    if nargin~=1
        error('Túl sok bemeneti paramétert adott meg, vagy éppen nem eleget!');
    end
%     img_matrix = imread('D:\ITK\Microfluidics\2016_2017_02\Results\image processing\counting\trichinella\images\From_new_videoset.png');
    % checking color
    if size(img_matrix,3)>1 % not grayscale
        G = rgb2gray(img_matrix);
    else
        G = img_matrix;
    end
    
    intensity = zeros(256,1); % look at zeros command in help
    
    for n = 1:size(G,1)
        for m = 1:size(G,2)
            intensity(G(n,m)+1) = intensity(G(n,m)+1) + 1;
        end
    end
    
%     figure
%     bar(0:255,intensity)
%     xlim([0 255])
%     xlabel('intensity value')
%     ylabel('number of occurences')
%     title('original histogram')
end