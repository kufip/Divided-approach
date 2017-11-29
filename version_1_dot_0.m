clear all
close all
% function [output_bw, output_fused] = ip_find_parasites (image)
dot = '.\input_images\';
name = 'CMF3_E7_7_Trichinella_live_50mlph_4x_v1_eleje.png'; % name of the input image
f_name = strcat(dot,name);
% image = imread('.\medium_dirty.png');
image = imread('.\F�T_input.png');

figure(7)
subplot(331)
imshow(image)
title('1. Original image')

% median filter a sz�nes k�pen, sz�ncsatorn�nk�nt
% it preserves edges while removing noise (Salt&Pepper)
b = 5;
a = 5; % compute with 5x5 Kernel
image_median = image;
for i=1:3
    Ch_i = image(:,:,i);
    Ch_i = medfilt2(Ch_i,[a,b],'symmetric');
    image_median(:,:,i)=Ch_i;
end
% save('image_median.mat', 'image_median');
HSV = rgb2hsv(image_median); %RGB k�p HSV-be val� konvert�l�sa
% sz�n�rnyalatokat k�nnyebben adok meg HSV-ben

S = HSV(:,:,2); % S csatorna kiemel�se

%{
figure(1)
subplot(121)
imshow(image)
subplot(122)
imshow(HSV)
%}

% original -> morph opening via Saturation
%{
figure(2)
subplot(231)
imshow(image)
title('original image')
subplot(232)
imshow(S)
title('1. Saturation from HSV')
%}

grayImage = rgb2gray(image); %RGB k�p sz�rke�rnyalatoss� konvert�l�sa
%{
figure(3)
subplot(121)
imshow(grayImage)
hold on
grayImage=imadjust(grayImage); %kontraszt korrekci�
subplot(122)
imshow(grayImage)
%}

gaussian1 = fspecial('Gaussian', 10,5); %1. Gauss sz�r�
gaussian2 = fspecial('Gaussian', 10,0.5); %2. Gauss sz�r�
%{
im_gauss1 = imgaussfilt(grayImage,5);
im_gauss1_c=conv2(double(grayImage),gaussian1,'same');
im_gauss2 = imgaussfilt(grayImage);
im_gauss2_c=conv2(double(grayImage),gaussian2,'same');
%}
dog = gaussian1 - gaussian2; % DoG
DOG = conv2(double(grayImage), dog, 'same'); % konvol�ci� a DoG kernellel
%{
subplot(131)
imshow(DOG)
DOG_1 = im_gauss1_c - im_gauss2_c;
figure(1)
subplot(231)
imshow(grayImage)
title('original')
subplot(232)
imshow(im_gauss1)
title('gaussian 5')
subplot(233)
imshow(uint8(im_gauss1_c))
title('gaussian 5 conv2')
subplot(234)
imshow(im_gauss2)
title('gaussian 0.5')
subplot(235)
imshow(uint8(im_gauss2_c))
title('gaussian 0.5 conv2')
subplot(236)
imshow(DOG)
title('DOG')
%}
figure(7)
subplot(332)
imshow(uint8(DOG))
title('2. Differnce of Gaussain')


%{
figure(4)
subplot(131)
imshow(DOG)
title('DOG')
figure(5)
subplot(121)
imshow(DOG)
title('DOG')
subplot(122)
imshow(DOG_1)
title('DOG with conv_2')
%}

S = imadjust(S); % kontraszt korrekc�
 % pixel intenzit�sok �tlaga
GUI_avg = 1.75;
avg = GUI_avg*(mean2(S));
%{
figure(2)
subplot(233)
imshow(S)
title('2. Saturation after contrast correction')
%}

% �tlag kivon�sa a k�pb�l
% megkapom a pixel�rt�kek sz�r�s�t
% kipr�b�lni nem az �tlaggal, hanem m�ssal
S = imsubtract(S,avg);


%{
figure(2)
subplot(234)
imshow(S)
title('3. after avg kivon�sa')
%}

% representation of avg modifications (after avg subs. -> morph. opening)
%{
figure(3)
subplot(231)
imshow(S)
title('original img after avg substraction')
subplot(234)
imshow(S_0)
title('modified img after avg substraction')
%}

figure(7)
subplot(333)
imshow(uint8(S))
title('3. Saturation')


% Otzu m�dszer
level = graythresh(S); % threshold �rt�k meghat�roz�sa Otzu m�dszerrel
bw = im2bw(S, level); % bin�ris maszk
% level f�l�tti �rt�kek -> 1, level alattiak -> 0


%{
figure(2)
subplot(235)
imshow(bw)
title('4. binary mask')
%}
%{
figure(3)
subplot(232)
imshow(bw)
title('original binary mask')
subplot(235)
imshow(bw_0)
title('modified binary mask')
%}

figure(7)
subplot(334)
imshow(uint8(bw))
title('4. Applying treshold for binary mask')


bw2 = bwmorph(bw, 'open');
% morfol�giai nyit�s
% open = eroion + dilation
%{
figure(2)
subplot(236)
imshow(bw2)
title('5. after morpholigal opening')
%}
%{
figure(3)
subplot(233)
imshow(bw2)
title('original after morphological opening')
subplot(236)
imshow(bw2_0)
title('modified after morphological opening')
%}

% comparing the original and the modified avg after morph. opening images
%{
figure(4)
subplot(121)
imshow(image)
title('input')
subplot(122)
imshow(bw2_0)
title('after morph. opening with 1.15*avg')
%}


figure(7)
subplot(335)
imshow(uint8(bw2))
title('5. Morphological opening')

% kism�ret� objektumok elt�vol�t�sa
% 100 + 15 pixeln�l kisebb ter�let� objektumok rep�lnek
max_area = 500;
bw2 = bwareafilt(bw2, [max_area Inf]);


figure(7)
subplot(336)
imshow(uint8(bw2))
title('6. Dropping out the small objects')

%{ 
figure(5)
subplot(131)
imshow(image)
title('original')
subplot(132)
imshow(bw2)
title('< 100')
subplot(133)
imshow(bw2_a)
title('<90')
%}
%{
% figure(2)
% subplot(236)


%}

%{
figure(4)
subplot(132)
imshow(bw2)
title('bw2')
%}
%{
figure(7)
subplot(231)
imshow(DOG)
subplot(232)
imshow(bw2)
subplot(234)
imshow(DOG)
%}
% DoG eredm�ny�nek maszkol�sa a kor�bban kapott bin�ris maszkkal
DOG(bw2==0) = 0; 

%{
subplot(233)
imshow(DOG)
title('original')
subplot(235)
imshow(bw2_a)
title('a')
subplot(236)
imshow(DOG_a)
%}

% kontraszt korrekci�
DOG_0 = imadjust(DOG);
%{
figure(8)
subplot(121)
imshow(DOG_0)
title('original')
subplot(122)
imshow(DOG_a0)
title('modified')
%}
%{
figure(3)
subplot(132)
%}
figure(7)
subplot(337)
imshow(uint8(DOG))
title('7. Contrast correction')


% f�l�sleges foltok, zajok kiv�tele
DOG(DOG_0<1) = 0;
%{
figure(9)
subplot(121)
imshow(DOG)
title('original')
subplot(122)
imshow(DOG_a)
title('modified')
%}
% I_0=imread('.\Images\After_algorithm.png');

%{
figure(3)
subplot(133)
figure(7)
subplot(338)
imshow(DOG)
title('8. Contrast correction')
%}



%{
figure(4)
subplot(133)
imshow(DOG)
title('DOG + bw2 mask tisztogat�s ut�n')
%}

% euklid�szi t�vols�g a legk�zelebbi non-zero elementtel
D = bwdist(~DOG,'euclidean'); 
%{
figure(10)
subplot(231)
imshow(D)
title('euklideszi t�vols�g')
%}

%{
figure(11)
subplot(231)
imshow(D_0)
title('euklideszi t�vols�g')
%}
%{
% valamif�le modifik�ci�, sz�r�s
D(D>0.5)=1;
figure(10)
subplot(232)
imshow(D)
title('valamif�le modifik�ci�, sz�r�s')

D_0(D_0>0.5)=1;
figure(11)
subplot(232)
imshow(D_0)
title('valamif�le modifik�ci�, sz�r�s')


% OTHER WAY
% morfol�giai nyit�s
D=bwmorph(D,'open'); 
figure(10)
subplot(233)
imshow(D)
title('morfol�giai nyit�s')

D_0=bwmorph(D_0,'open');
figure(11)
subplot(233)
imshow(D_0)
title('morfol�giai nyit�s')

% kis m�ret� objektumok elt�vol�t�sa
D = bwareafilt(D, [200 Inf]);
figure(10)
subplot(234)
imshow(D)
title('kis m�ret� objektumok elt�vol�t�sa >200')

D_0 = bwareafilt(D_0, [200 Inf]);
figure(11)
subplot(234)
imshow(D_0)
title('kis m�ret� objektumok elt�vol�t�sa >200')


% skeletoniz�l�s
D=bwmorph(D, 'skel', Inf);
figure(10)
subplot(235)
imshow(D)
title('skeletoniz�l�s')

D_0=bwmorph(D_0, 'skel', Inf);
figure(11)
subplot(235)
imshow(D_0)
title('skeletoniz�l�s')
%}


% kis le�gaz�sok elt�vol�t�sa
D = bwmorph(D, 'spur', 5);
%{
figure(10)
subplot(236)
imshow(D)
title('kis le�gaz�sok elt�vol�t�sa')
%}

%{
figure(11)
subplot(236)
imshow(D_0)
title('kis le�gaz�sok elt�vol�t�sa')
%}



% zajok elt�vol�t�sa
output_bw = bwmorph(D, 'clean');
save('sat_bw_9.mat','output_bw');

% figure(10)
% imshow(output_bw)
% figure(11)
% imshow(bw2)

figure(7)
subplot(338)
imshow(uint8(output_bw))
title('8. Geometric operations')

% reprezent�ci�hoz kell
output_fused = imfuse(image, output_bw);

figure(7)
subplot(339)
imshow(output_fused)
title('9. Result')

figure(12)
imshow(output_fused)
title('Output')

out = '.jpg';
out = strcat(f_name,out);
imwrite(output_fused, out);

% Measurement
count = 0;
for n = 1:size(output_bw,1)
    for m = 1:size(output_bw,2)
        if (output_bw(n,m) == 1)
            count = count+1;
        end
    end
end

all_pixel = size(output_bw,1)*size(output_bw,2);
ratio = count/all_pixel;

% Megn�zni hogy az utols� m�veletekn�l mennyi inf� veszik el!
%{
count = 0;
for n = 1:size(output_bw_0,1)
    for m = 1:size(output_bw_0,2)
        if (output_bw_0(n,m) == 1)
            count = count+1;
        end
    end
end

all_pixelo = size(output_bw_0,1)*size(output_bw_0,2);
ratioo = count/all_pixel;
%}
% 
