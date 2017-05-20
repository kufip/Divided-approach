clear all
close all
clc

% MATS
sat_1 = load('.\Mats\Saturation mats\sat_bw_1.mat');
sat_3 = load('.\Mats\Saturation mats\sat_bw_3.mat');
sat_6 = load('.\Mats\Saturation mats\sat_bw_6.mat');
sat_9 = load('.\Mats\Saturation mats\sat_bw_9.mat');
d_1 = load('.\Mats\Canny edge detector mats\d_1.mat');
d_3 = load('.\Mats\Canny edge detector mats\d_3.mat');
d_6 = load('.\Mats\Canny edge detector mats\d_6.mat');
d_9 = load('.\Mats\Canny edge detector mats\d_9.mat');
para_no_1 = load('.\Mats\real_para_1.mat');
para_no_3 = load('.\Mats\real_para_3.mat');
para_no_6 = load('.\Mats\real_para_6.mat');
para_no_9 = load('.\Mats\real_para_9.mat');

% CANNY EREDMÉNYEI
d_1 = d_1.d;
d_3 = d_3.d;
d_6 = d_6.d;
d_9 = d_9.d;
% SATURATION EREDMÉNYEI
sat_1 = padarray(sat_1.output_bw,[3 3]);
sat_3 = padarray(sat_3.output_bw,[3 3]);
sat_6 = padarray(sat_6.output_bw,[3 3]);
sat_9 = padarray(sat_9.output_bw,[3 3]);
% SZÁMOLÁSOK
para_no_1 = para_no_1.count;
para_no_3 = para_no_3.count;
para_no_6 = para_no_6.count;
para_no_9 = para_no_9.count;
imread('.\D:\ITK\Microfluid\2016_2017_02\Results\image processing\counting\trichinella\Divided approach\input_images\CMF3_E7_7_Trichinella_live_50mlph_4x_v1_eleje.png');

% COUNTING RATIO
%{
count=0;
% object 1
for n = 477:517
    for m = 301:423
       if d_9(n,m) > 0 || sat_9(n,m) == 1
           count = count+1;
       end
    end
end
% object 2
for n = 321:501
    for m = 447:591
       if d_9(n,m) > 0 || sat_9(n,m) == 1
           count = count+1;
       end
    end
end
% object 3 + 4
for n = 272:310
    for m = 514:596
       if d_9(n,m) > 0 || sat_9(n,m) == 1
           count = count+1;
       end
    end
end
% object 5
for n = 199:521
    for m = 544:573
       if d_9(n,m) > 0 || sat_9(n,m) == 1
           count = count+1;
       end
    end
end
% object 6
for n = 127:175
    for m = 350:399
       if d_9(n,m) > 0 || sat_9(n,m) == 1
           count = count+1;
       end
    end
end
%}
avg=0;
ratio=0;
count_all=0;
for n = 1:size(d_1,1)
    for m = 1:size(d_1,2)
       if d_9(n,m) > 0 || sat_9(n,m) == 1
            count_all = count_all+1;
       end
    end
end
avg = (para_no_1 + para_no_3 + para_no_6 + para_no_9)/19;
ratio = count_all/avg;

% save('real_para_9.mat','count')
% imwrite(uint8(imfuse(sat_9,d_9)),'para9.png');

% FIGURES
% figure(1)
% imshow(uint8(imfuse(sat_1,d_1)))
% set(gcf,'Position',[1367 -91 1440 783])
% figure(2)
% imshow(uint8(imfuse(sat_3,d_3)))
% set(gcf,'Position',[1367 -91 1440 783])
% figure(3)
% imshow(uint8(imfuse(sat_6,d_6)))
% set(gcf,'Position',[1367 -91 1440 783])
figure(4)
imshow(uint8(imfuse(sat_9,d_9)))
% set(gcf,'Position',[1367 -91 1440 783])
