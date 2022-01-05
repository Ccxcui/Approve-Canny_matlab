function gaussian_matrix = gaussian_filter(size, sigma)
    gaussian_matrix = zeros(size, size);
    coef = 1 / (2 * 3.14159265 * sigma * sigma);
    total_sum = 0;
    for i = 1:size
        for j = 1:size
            x2 = (j - (size + 1)  / 2)^2;
            y2 = (i - (size + 1)  / 2)^2;
            gaussian_matrix(i, j) = coef * exp(-(x2 + y2) / (2 * sigma * sigma));
            total_sum = total_sum + gaussian_matrix(i, j);
        end
    end
    % 使得矩阵中所有元素和为1
    gaussian_matrix = gaussian_matrix / total_sum;
end
