function [output_fused,ratio] = divided_approach(image,GUI_avg,max_area)

    if nargin~=3
        error('Too many or not enough input parameter!');
    end
    % reading the image
%     image=imread('D:\ITK\Microfluidics\2016_2017_02\Results\image processing\counting\trichinella\images\From_new_videoset.png');
    
    % image a Load-tól jön

    % median filter preserves edges while removing noise (Salt&Pepper)
    a=5;
    b=5;
    image_median=image;
    for i=1:3
        Ch_i=image(:,:,i);
        Ch_i=medfilt2(Ch_i,[a,b],'symmetric');
        image_median(:,:,i)=Ch_i;
    end
    
    HSV=rgb2hsv(image_median); % convertint the image into HSV
    S=HSV(:,:,2); % getting out the S channel
    grayImage=rgb2gray(image); % converting the image into grayscale
    
    % creating the Differnce Of Gaussian
    gaussian1 = fspecial('Gaussian', 10,5); %1. Gauss szûrõ
    gaussian2 = fspecial('Gaussian', 10,0.5); %2. Gauss szûrõ
    dog = gaussian1 - gaussian2;
    DOG = conv2(double(grayImage), dog, 'same');
    
    S = imadjust(S); % contrast correction
%     avg = (mean2(S)); % avg of pixel intensities
    avg = GUI_avg*(mean2(S)); % counting the modified avg
    S = imsubtract(S,avg); % substract the avg from S channel
    
    % Otzu method for treshold level
    level=graythresh(S);
    bw=im2bw(S, level); % binary mask
    
    bw2 = bwmorph(bw, 'open'); % morphological opening
    
    % clean the small stuctures on the image
    bw2 = bwareafilt(bw2, [max_area Inf]);
    
    % masking
    DOG(bw2==0)=0;
    
    DOG_0=imadjust(DOG);
    DOG(DOG_0<1)=0;
    D = bwdist(~DOG,'euclidean');
    D=bwmorph(D, 'spur', 5);
    output_bw=bwmorph(D, 'clean');
    output_fused=imfuse(image, output_bw);
%     imwrite(output_fused,'output.jpg');
%     figure(1)
%     imshow(output_fused)
%     title('Result')
    
    ratio = div_appr_meas(bw2);
end