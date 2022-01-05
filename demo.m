%%
clear all;
close all;
clc;
%%
%I/O file
File_input_name = './Dataset/input2.jpg'; %if error, check the image format, png/jpg
File_output_name = './Dataset/output2.png';
%%
%Computational_Imaging
I = imread(File_input_name);
output = Edge_Detection_Autothreshold(I);
imwrite(output, File_output_name);
Igray=rgb2gray(I);
output1=edge(Igray, 'Canny');

%%
%plotting
figure;
subplot(2,2,1);
imshow(uint8(I)),title("原图"); 
subplot(2,2,2);
imshow(output),title("自动阈值");
subplot(2,2,4);
imshow(output1);