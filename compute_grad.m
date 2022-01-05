function [grad, grad_direction] = compute_grad(img_filter)
    % 索贝尔算子
    sobel = [-1.0 0.0 1.0;-2.0 0.0 2.0;-1.0 0.0 1.0];

    % 计算图像的sobel水平梯度 
    gradx=conv2(img_filter, sobel, 'same');
    % gradx = imfilter(apple_filter, sobel, 'replicate');

    % 计算图像的sobel垂直梯度 
    grady=conv2(img_filter, sobel', 'same');
    % grady = imfilter(apple_filter, sobel', 'replicate');

    % 得到图像的sobel梯度以及方向, 使用绝对值代替平方开方
    grad=sqrt(gradx.^2+grady.^2);
    grad_direction = atan(grady./gradx);
end
