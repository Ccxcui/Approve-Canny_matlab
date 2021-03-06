clear all;
clc;
%读取照片
peppers = imread('../peppers.png');
peppers = rgb2gray(peppers);
figure(1);
subplot(321),
imshow(peppers);

%% 用matlab封装的四种算子做边缘检测
%转为uint8类型是因为封装函数返回的是二值图
%我要把二值图的1转为255，是为了和openCV的边缘检测函数返回值对应
Mcanny = edge(peppers,'canny');
Mcanny = uint8(Mcanny);
Mcanny(Mcanny == 1) = 255;
subplot(322),
imshow(Mcanny);

sobel = edge(peppers,'sobel');
sobel = uint8(sobel);
sobel(sobel == 1) = 255;
subplot(323),
imshow(sobel);

prewitt = edge(peppers,'prewitt');
prewitt = uint8(prewitt);
prewitt(prewitt == 1) = 255;
subplot(324),
imshow(prewitt);

log = edge(peppers,'log');
log = uint8(log);
log(log == 1) = 255;
subplot(325),
imshow(log);
%% 定量分析边缘检测结果的优劣
% 参考的文献是《一种新的基于连通成分的边缘评价方法 林卉》
% 上述文章的描述可能错在错误(连通成分数的求法，我觉得有有问题)，我基于自己的理解实现了文献提到的评价方法
% A是图中边的像素个数
% B是图中的四连通成分数
% C是图中的八联通成份数
% C/A和C/B两个值越小 -> 边缘检测的效果越好
aOfMcanny = calcA(Mcanny);
aOfsobel = calcA(sobel);
aOfprewitt = calcA(prewitt);
aOflog = calcA(log);
%plot(aOfMcanny,aOfsobel,aOfprewitt);


bOfMcanny = calcB(Mcanny);
bOfsobel = calcB(sobel);
bOfprewitt = calcB(prewitt);
bOflog = calcB(log);


cOfMcanny = calcC(Mcanny);
cOfsobel = calcC(sobel);
cOfprewitt = calcC(prewitt);
cOflog = calcC(log);


%%

peppers1 = imread('../图片/改进canny1.jpg');
imshow(peppers1)
peppers1 = uint8(peppers1);
peppers1(peppers1 == 1) = 255;
aOfpeppers1 = calcA(peppers1);
bOfpeppers1 = calcB(peppers1);
cOfpeppers1 = calcC(peppers1);
