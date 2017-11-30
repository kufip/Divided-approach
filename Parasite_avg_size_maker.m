clc
clear all
close all
% Funghi (OK)
p1='CMF3_E8_2_Trichinella_live_4,5mlph_4x_v1_1st.png';
p2='CMF3_E8_2_Trichinella_live_4,5mlph_4x_v1_2nd.png';
p3='CMF3_E8_2_Trichinella_live_6mlph_4x_v1_1st.png';
p4='CMF3_E8_2_Trichinella_live_6mlph_4x_v1_2nd.png';
p5='CMF3_E8_11_Trichinella_live_kezi_4x_v1_1st.png';
p6='CMF3_E8_11_Trichinella_live_kezi_4x_v1_2nd.png';
p7='CMF3_E8_12_Trichinella_live_25mlph_4x_v1_1st.png';
p8='CMF3_E8_12_Trichinella_live_25mlph_4x_v1_2nd.png';
p9='CMF3_E8_12_Trichinella_live_35mlph_4x_v1_1st.png';
p10='CMF3_S_Trichinella_live_100mlph_4x_v1_test_1st.png';
% Sok parazitát tartalmazó képek (>=15) (OK) !!
p11='CMF3_E6_11_Trichinella_live_2,5mlph_4x_v1_1st.png';
p12='CMF3_E6_11_Trichinella_live_2,5mlph_4x_v1_2nd.png';
p13='CMF3_E6_11_Trichinella_live_2,5mlph_4x_v1_3rd.png';
p14='CMF3_E6_11_Trichinella_live_3,5mlph_4x_v1_1st.png';
p15='CMF3_E6_11_Trichinella_live_3mlph_4x_v1_1st.png';
p16='CMF3_E6_11_Trichinella_live_3mlph_4x_v1_2nd.png';
p17='CMF3_E6_11_Trichinella_live_3mlph_4x_v1_3rd.png';
p18='CMF3_S6_2_Trichinella_live_20mlph_4x_v2_1st.png';
p19='CMF3_S6_2_Trichinella_live_25mlph_4x_v2_1st.png';
p20='CMF3_S6_2_Trichinella_live_25mlph_4x_v2_2nd.png';
% Közepes (8-15 parazita) (OK) !!
p21='CMF3_S6_2_Trichinella_live_3,5mlph_4x_v1_1st.png';
p22='CMF3_S6_2_Trichinella_live_3,5mlph_4x_v1_2nd.png';
p23='CMF3_S6_2_Trichinella_live_7mlph_4x_v1_1st.png';
p24='CMF3_S6_2_Trichinella_live_7mlph_4x_v1_2nd.png';
p25='CMF3_S6_3_Trichinella_live_4,5mlph_4x_v3_1st.png';
p26='CMF3_S6_3_Trichinella_live_8mlph_4x_v3_1st.png';
p27='CMF3_S6_3_Trichinella_live_8mlph_4x_v3_2nd.png';
p28='CMF3_S6_4_Trichinella_live_7mlph_4x_v1_2nd.png';
p29='CMF3_S6_4_Trichinella_live_9mlph_4x_v1_1st.png';
p30='CMF3_S6_4_Trichinella_live_9mlph_4x_v1_2nd.png';
% Kevés (<8 parazita) (OK) !!
p31='CMF3_E6_10_Trichinella_live_4,5mlph_4x_v1_1st.png';
p32='CMF3_E6_10_Trichinella_live_8mlph_4x_v1_1st.png';
p33='CMF3_E7_11_Trichinella_live_3,5mlph_4x_v1_1st.png';
p34='CMF3_E7_11_Trichinella_live_3,5mlph_4x_v1_2nd.png';
p35='CMF3_E8_1_Trichinella_live_9mlph_4x_v1_1st.png';
p36='CMF3_E8_1_Trichinella_live_30mlph_4x_v1_1st.png';
p37='CMF3_E8_11_Trichinella_live_9mlph_4x_v2_1st.png';
p38='CMF3_S6_4_Trichinella_live_6mlph_4x_v1_1st.png';
p39='CMF3_S6_5_Trichinella_live_4mlph_4x_v1_1st.png';
p40='CMF3_S6_5_Trichinella_live_5mlph_4x_v1_1st.png';
% Dirty (OK) !!
p41='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_1st.png';
p42='CMF3_E8_5_Trichinella_live_7mlph_4x_v1_1st.png';
p43='CMF3_E8_5_Trichinella_live_7mlph_4x_v1_2d.png';
p44='CMF3_E8_5_Trichinella_live_8mlph_4x_v1_1st.png';
p45='CMF3_E8_5_Trichinella_live_8mlph_4x_v1_2nd.png';
p46='CMF3_E8_5_Trichinella_live_9mlph_4x_v1_1st.png';
p47='CMF3_E8_5_Trichinella_live_25mlph_4x_v1_1st.png';
p48='CMF3_E8_5_Trichinella_live_35mlph_4x_v1_1st.png';
p49='CMF3_E8_11_Trichinella_live_30mlph_4x_v1_1st.png';
p50='CMF3_E8_11_Trichinella_live_kezi_4x_v1_1st.png';
% Random (OK) !!
p51='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1.png';
p52='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para3.png';
p53='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para6.png';
p54='1.png';
p55='2.png';
p56='3.png';
p57='4.png';

str_base = '.\input_images\Training set\Funghi\';
I = imread(strcat(str_base,...
    p1));
[~, BW] = Canny_edge_detector_func(I,...
    160,140);
figure, imshow(I), ... %figure, imshow(hyst), title('Hysterises image'),...
    figure, imshow(BW), title('BW image')
BW_largest = bwareafilt(BW,...
    3); % kép alapján minek észlelte
figure, imshow(BW_largest)
CC_largest = bwconncomp(BW_largest);
sum_pixel=0;
for n=1:CC_largest.NumObjects
    sum_pixel = sum_pixel + size(CC_largest.PixelIdxList{1,n},1);
end

parasite_avg_pixel_size = sum_pixel/...
    3; % valós érték alapján mennyi látható

avg1=667.6667; avg2=718.3333; avg3=803.3333; avg4=330.4; avg5=2055.8; avg6=1924; avg7=1145.75;
avg8=1645.25; avg9=1733.25; avg10=663.3333; avg11=299.6111; avg12=554.3750; avg13=407.1667; avg14=178.3919;
avg15=544.8333; avg16=529.5; avg17=442.9429; avg18=963; avg19=889.1875; avg20=808.6250; avg21=1103;
avg22=1648.1666; avg23=889.5; avg24=975.3043; avg25=489.1250; avg26=663.7500; avg27=495.4545; avg28=434.7;
avg29=633.2727; avg30=750.4167; avg31=2731; avg32=2845; avg33=659.6667; avg34=627.8333; avg35=1128;
avg36=1015; avg37=766.6667; avg38=1187.8333; avg39=332; avg40=877; avg41=1106.4444; avg42=1155.6666;
avg43=1403.6666; avg44=1352.8; avg45=1413; avg46=1402.2; avg47=1339.4; avg48=1572.2; avg49=877;
avg50=977; avg51=740; avg52=704; avg53=820.6667; avg54=332.3333; avg55=832.6667; avg56=600;
avg57=569.0270;

avg_values = [avg1,avg2,avg3,avg4,avg5,avg6,avg7,avg8,avg9,avg10...
    avg11,avg12,avg13,avg14,avg15,avg16,avg17,avg18,avg19,avg20,...
    avg21,avg22,avg23,avg24,avg25,avg26,avg27,avg28,avg29,avg30,...
    avg31,avg32,avg33,avg34,avg35,avg36,avg37,avg38,avg39,avg40,...
    avg41,avg42,avg43,avg44,avg45,avg46,avg47,avg48,avg49,avg50,...
    avg51,avg52,avg53,avg54,avg55,avg56,avg57]';

% avg(avg)
avg_avg=0;
for n=1:57 
    avg_avg = avg_avg + avg_values(n,1);
end
avg_avg = avg_avg/57;
% variancia intervallum meghatározásához
min_avg = min(avg_values);
max_avg = max(avg_values);
abs_diff_avg = zeros(size(avg_values,1),1); % átlagok abszolút eltérése az átlagok átlagától
for n=1:size(avg_values,1)
    abs_diff_avg(n,1) = abs(avg_values(n,1)-avg_avg);
end
sum=0;
for n=1:size(abs_diff_avg,1)
    sum = sum + abs_diff_avg(n,1);
end
avg_abs_diff_avg = sum/size(abs_diff_avg,1); % átlagok abszolút eltérésének átlaga
parasite_size_interval = [avg_avg-avg_abs_diff_avg;avg_avg+avg_abs_diff_avg];
avg_infos = struct('Average_of_average_parasite_sizes', avg_avg,...
    'Minimum_of_average_prasite_sizes', min_avg,...
    'Maximum_of_average_prasite_sizes', max_avg,...
    'Average_of_abs_differences_of_average_parasite_sizes',avg_abs_diff_avg,...
    'Abs_difference_of_average_prasite_sizes', abs_diff_avg,...
    'Parasite_size_interval',parasite_size_interval);

    
% avg_infos_table = struct2table(avg_infos);
% writetable(avg_infos_table,'avg_infos.xlsx');

% exportálásra tökéletes
% Funghi (OK)
p1='CMF3_E8_2_Trichinella_live_4_5mlph_4x_v1_1st';
p2='CMF3_E8_2_Trichinella_live_4_5mlph_4x_v1_2nd';
p3='CMF3_E8_2_Trichinella_live_6mlph_4x_v1_1st';
p4='CMF3_E8_2_Trichinella_live_6mlph_4x_v1_2nd';
p5='CMF3_E8_11_Trichinella_live_kezi_4x_v1_1st';
p6='CMF3_E8_11_Trichinella_live_kezi_4x_v1_2nd';
p7='CMF3_E8_12_Trichinella_live_25mlph_4x_v1_1st';
p8='CMF3_E8_12_Trichinella_live_25mlph_4x_v1_2nd';
p9='CMF3_E8_12_Trichinella_live_35mlph_4x_v1_1st';
p10='CMF3_S_Trichinella_live_100mlph_4x_v1_test_1st';
% Sok parazitát tartalmazó képek (>=15) (OK) !!
p11='CMF3_E6_11_Trichinella_live_2_5mlph_4x_v1_1st';
p12='CMF3_E6_11_Trichinella_live_2_5mlph_4x_v1_2nd';
p13='CMF3_E6_11_Trichinella_live_2_5mlph_4x_v1_3rd';
p14='CMF3_E6_11_Trichinella_live_3_5mlph_4x_v1_1st';
p15='CMF3_E6_11_Trichinella_live_3mlph_4x_v1_1st';
p16='CMF3_E6_11_Trichinella_live_3mlph_4x_v1_2nd';
p17='CMF3_E6_11_Trichinella_live_3mlph_4x_v1_3rd';
p18='CMF3_S6_2_Trichinella_live_20mlph_4x_v2_1st';
p19='CMF3_S6_2_Trichinella_live_25mlph_4x_v2_1st';
p20='CMF3_S6_2_Trichinella_live_25mlph_4x_v2_2nd';
% Közepes (8-15 parazita) (OK) !!
p21='CMF3_S6_2_Trichinella_live_3_5mlph_4x_v1_1st';
p22='CMF3_S6_2_Trichinella_live_3_5mlph_4x_v1_2nd';
p23='CMF3_S6_2_Trichinella_live_7mlph_4x_v1_1st';
p24='CMF3_S6_2_Trichinella_live_7mlph_4x_v1_2nd';
p25='CMF3_S6_3_Trichinella_live_4_5mlph_4x_v3_1st';
p26='CMF3_S6_3_Trichinella_live_8mlph_4x_v3_1st';
p27='CMF3_S6_3_Trichinella_live_8mlph_4x_v3_2nd';
p28='CMF3_S6_4_Trichinella_live_7mlph_4x_v1_2nd';
p29='CMF3_S6_4_Trichinella_live_9mlph_4x_v1_1st';
p30='CMF3_S6_4_Trichinella_live_9mlph_4x_v1_2nd';
% Kevés (<8 parazita) (OK) !!
p31='CMF3_E6_10_Trichinella_live_4_5mlph_4x_v1_1st';
p32='CMF3_E6_10_Trichinella_live_8mlph_4x_v1_1st';
p33='CMF3_E7_11_Trichinella_live_3_5mlph_4x_v1_1st';
p34='CMF3_E7_11_Trichinella_live_3_5mlph_4x_v1_2nd';
p35='CMF3_E8_1_Trichinella_live_9mlph_4x_v1_1st';
p36='CMF3_E8_1_Trichinella_live_30mlph_4x_v1_1st';
p37='CMF3_E8_11_Trichinella_live_9mlph_4x_v2_1st';
p38='CMF3_S6_4_Trichinella_live_6mlph_4x_v1_1st';
p39='CMF3_S6_5_Trichinella_live_4mlph_4x_v1_1st';
p40='CMF3_S6_5_Trichinella_live_5mlph_4x_v1_1st';
% Dirty (OK) !!
p41='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_1st';
p42='CMF3_E8_5_Trichinella_live_7mlph_4x_v1_1st';
p43='CMF3_E8_5_Trichinella_live_7mlph_4x_v1_2d';
p44='CMF3_E8_5_Trichinella_live_8mlph_4x_v1_1st';
p45='CMF3_E8_5_Trichinella_live_8mlph_4x_v1_2nd';
p46='CMF3_E8_5_Trichinella_live_9mlph_4x_v1_1st';
p47='CMF3_E8_5_Trichinella_live_25mlph_4x_v1_1st';
p48='CMF3_E8_5_Trichinella_live_35mlph_4x_v1_1st';
p49='CMF3_E8_11_Trichinella_live_30mlph_4x_v1_1st';
p50='CMF3_E8_11_Trichinella_live_kezi_4x_v1_1st_dirty';
% Random (OK) !!
p51='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para1';
p52='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para3';
p53='CMF3_E7_7_Trichinella_live_50mlph_4x_v1_para6';
p54='Random_1';
p55='Random_2';
p56='Random_3';
p57='Random_4';
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
avg_values_table = struct2table(avg_values_struct);
writetable(avg_values_table,'avg_values.xlsx');
% cell = struct2cell(avg_values_struct);
% fid = fopen('avg_values.txt','wt');
% fprintf(fid,'%s,%s,%s,%f\n', cell{:});