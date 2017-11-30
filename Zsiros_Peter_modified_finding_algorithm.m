function [output_fused,output_bw] = Zsiros_Peter_modified_finding_algorithm(image,GUI_avg,max_area)

    if nargin~=3
        error('Too many or not enough input parameter!');
    end

    % median filter preserves edges while removing noise (Salt&Pepper)
    a=5;
    b=5;
    image_median=image;
    for i=1:3
        Ch_i=image(:,:,i);
        Ch_i=medfilt2(Ch_i,[a,b],'symmetric');
        image_median(:,:,i)=Ch_i;
    end
    
    HSV=rgb2hsv(image_median); % converting the image into HSV
    S=HSV(:,:,2); % getting out the S channel
    grayImage=rgb2gray(image); % converting the image into grayscale
    
    % creating the Differnce Of Gaussian
    gaussian1 = fspecial('Gaussian', 10,5); %1. Gauss szûrõ
    gaussian2 = fspecial('Gaussian', 10,0.5); %2. Gauss szûrõ
    dog = gaussian1 - gaussian2;
    DOG = conv2(double(grayImage), dog, 'same');
    
    S = imadjust(S); % contrast correction
    avg = GUI_avg*(mean2(S)); % computing the modified avg
    
    S = imsubtract(S,avg); % substract the avg from S channel
    
    % Otzu method for treshold level
    level=graythresh(S);
    bw=im2bw(S, level); % binary mask
    
    bw2 = bwmorph(bw, 'open'); % morphological opening
    
    % cleaning the small object from the image
    bw2 = bwareafilt(bw2, [100 Inf]);
    
    % masking
    DOG(bw2==0)=0;
    DOG=imadjust(DOG); %contrast correction
    DOG(DOG<1)=0;
    
    D = bwdist(~DOG,'euclidean'); %Euclidean distance
%     D(D>0.5)=1;
%     D=bwmorph(D,'open'); %morphological opening
%     D = bwareafilt(D, [200 Inf]); %cleaning the small object from the image
    D=bwmorph(D, 'skel', Inf); %making sceleton
    D=bwmorph(D, 'spur', 5); %eliminating small branches
    output_bw=bwmorph(D, 'clean'); %noise filtering
    
    output_fused=imfuse(image, output_bw);
