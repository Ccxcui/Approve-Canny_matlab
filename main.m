%% =============== Part 0: 读取图像 ================
clc;clear all;
%img = imread('cell.png');
%img=imread('lena.jpg');
img=imread('peppers.png');
img_gray = double(rgb2gray(img));

figure(),subplot(151),imshow(uint8(img_gray)),xlabel("灰度图");
%imwrite(uint8(img_gray),"灰度图3.jpg");

%% =============== Part 1: 高斯平滑处理 ================
% 生成高斯模版
%H = gaussian_filter(5, 0.8);
%apple_filter1=imfilter(apple_gray, H, 'replicate');

knn_filter = knnFilter(img_gray);
subplot(152),imshow(uint8(knn_filter)),xlabel("k近邻中值滤波");
%imwrite(uint8(knn_filter),"k近邻中值滤波3.jpg");
%% =============== Part 2: 索贝尔算子计算梯度值及方向 ================
[grad, grad_direction] = compute_grad(knn_filter);
subplot(153),imshow(uint8(grad)),xlabel("sobel");
%imwrite(uint8(grad),"sobel-grad3.jpg");
%% =============== Part 3: 非极大值抑制 ================
non_maximum_restrain = non_maximum_restrain(grad, grad_direction);
subplot(154),imshow(uint8(non_maximum_restrain)),xlabel("非极大值抑制");
%imwrite(uint8(non_maximum_restrain),"非极大值抑制3.jpg");
%% =============== Part 4: 双阈值检测 ================
threshold=generate_threshold(non_maximum_restrain);
approve_canny = dual_threshold_detection(non_maximum_restrain, threshold(1), threshold(2));
%threshold=get_threld(non_maximum_restrain,0.001);
%approve_canny = dual_threshold_detection(non_maximum_restrain, threshold/2, threshold);
subplot(155),imshow(uint8(approve_canny)),xlabel("自动阈值检测");
%imwrite(uint8(approve_canny),"改进canny3.jpg");

%%
imwrite(uint8(approve_canny),"改进canny1.jpg");
%%
figure()
sobel_default=edge(img_gray,'sobel');
prewitt_default=edge(img_gray,'prewitt');
log_default=edge(img_gray,'log');
canny_default=edge(img_gray,'canny');

subplot(161),imshow(uint8(img_gray)),xlabel("灰度图");

subplot(162),imshow(sobel_default),xlabel("sobel");
%imwrite(sobel_default,"sobel3.png");

subplot(163),imshow(prewitt_default),xlabel('prewitt');
%imwrite(prewitt_default,"prewitt3.png");

subplot(164),imshow(log_default),xlabel('log');
%imwrite(log_default,"log3.png");

subplot(165),imshow(canny_default),xlabel('default canny');
%imwrite(canny_default,"default canny3.png");

subplot(166),imshow(uint8(approve_canny)),xlabel('approve canny');


