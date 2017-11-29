p1='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p2='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para3.png';
p3='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para6.png';
p4='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para9.png'; % dirty
p5='funghi.png';
p6='hard_dirty.png'; % dirty
p7='little_dirty.png'; % dirty
p8='medium_dirty.png'; % dirty
p9='probe_0.png'; % dirty
p10='probe_1.png'; % dirty
p11='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p12='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p13='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p14='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p15='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p16='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p17='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p18='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p19='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p20='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p21='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p22='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p23='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p24='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p25='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p26='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p27='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p28='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p29='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p30='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p31='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p32='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p33='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p34='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p35='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p36='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p37='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p38='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p39='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p40='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p41='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p42='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p43='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p44='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p45='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p46='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p47='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p48='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p49='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p50='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p51='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p52='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p53='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p54='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p55='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p56='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p57='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';

str_base = '.\input_images';
I = imread(strcat(str_base,...
    p1));
[~, BW,hyst] = Canny_edge_detector_func(I,...
    150,120);
figure, imshow(I), figure, imshow(hyst), title('Hysterises image'),...
    figure, imshow(BW), title('BW image')
BW_largest = bwareafilt(BW,...
    5); % kép alapján minek észlelte
figure, imshow(BW_largest)
CC_largest = bwconncomp(BW_largest);
sum_pixel=0;
for n=1:CC_largest.NumObjects
    sum_pixel = sum_pixel + size(CC_largest.PixelIdxList{1,n},1);
end

parasite_avg_pixel_size = sum_pixel/...
    6; % valós érték alapján mennyi látható

avg1=0; avg2=0; avg3=0; avg4=0; avg5=0; avg6=0; avg7=0;
avg8=0; avg9=0; avg10=0; avg11=0; avg12=0; avg13=0; avg14=0;
avg15=0; avg16=0; avg17=0; avg18=0; avg19=0; avg20=0; avg21=0;
avg22=0; avg23=0; avg24=0; avg25=0; avg26=0; avg27=0; avg28=0;
avg29=0; avg30=0; avg31=0; avg32=0; avg33=0; avg34=0; avg35=0;
avg36=0; avg37=0; avg38=0; avg39=0; avg40=0; avg41=0; avg42=0;
avg43=0; avg44=0; avg45=0; avg46=0; avg47=0; avg48=0; avg49=0;
avg50=0; avg51=0; avg52=0; avg53=0; avg54=0; avg55=0; avg56=0;
avg57=0;

avg_values = [avg1,avg2,avg3,avg4,avg5,avg6,avg7,avg8,avg9,avg10...
    avg11,avg12,avg13,avg14,avg15,avg16,avg17,avg18,avg19,avg20,...
    avg21,avg22,avg23,avg24,avg25,avg26,avg27,avg28,avg29,avg30,...
    avg31,avg32,avg33,avg34,avg35,avg36,avg37,avg38,avg39,avg40,...
    avg41,avg42,avg43,avg44,avg45,avg46,avg47,avg48,avg49,avg50,...
    avg51,avg52,avg53,avg54,avg55,avg56,avg57]';

% avg(avg)
avg_avg=0;
for n=1:57 
    avg_avg = (avg_avg + avg_values(n,1))/57;
end
% variancia intervallum meghatározásához
min_avg = min(avg_values);
max_avg = max(avg_values);

avg_variance = struct('Average of average prasite sites (57)', avg_avg,...
    'Minimum of average prasite sites (57)', min_avg,...
    'Maximum of average prasite sites (57)', max_avg);

% exportálásra tökéletes
avg_values_struct = struct(p1,avg1,p2,avg2,p3,avg3,p4,avg4,p5,avg5,...
    p6,avg6,p7,avg7,p8,avg8,p9,avg9,p10,avg10,...
    p11,avg11,p12,avg12,p13,avg13,p14,avg14,p15,avg15,...
    p16,avg16,p17,avg17,p18,avg18,p19,avg19,p20,avg20,...
    p21,avg21,p22,avg22,p23,avg23,p24,avg24,p25,avg25,...
    p26,avg26,p27,avg27,p28,avg28,p29,avg29,p30,avg30,...
    p31,avg31,p32,avg32,p33,avg33,p34,avg34,p35,avg35,...
    p36,avg36,p37,avg37,p38,avg38,p39,avg39,p40,avg40,...
    p41,avg41,p42,avg42,p43,avg43,p44,avg44,p45,avg45,...
    p46,avg46,p47,avg47,p48,avg48,p49,avg49,p50,avg50,...
    p51,avg51,p52,avg52,p53,avg53,p54,avg54,p55,avg55,...
    p56,avg56,p57,avg57);