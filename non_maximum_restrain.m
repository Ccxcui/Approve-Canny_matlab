function canny = non_maximum_restrain(grad, grad_direction)
    [m, n] = size(grad_direction);
    sector = zeros(m, n);
    canny = zeros(m, n);
    % 构造
    % 2 1 0
    % 3 x 3
    % 0 1 2
    for i=1:m
        for j=1:n
            angle = grad_direction(i, j);
            if (angle < 3*pi/4) && (angle >= pi/4)
                sector(i, j) = 0;    
            elseif (angle < pi/4) && (angle >= -pi/4)
                sector(i, j) = 3;    
            elseif (angle < -pi/4) && (angle >= -3*pi/4)
                sector(i, j) = 2;    
            else
                sector(i, j) = 1;    
            end    
        end
    end
    % 判断没一点像素的梯度方向，并和该方向上的数值进行比较
    for i=2:m-1
        for j=2:n-1
            if (sector(i, j) == 0) % 45度
                if ((grad(i, j) > grad(i - 1, j + 1) && grad(i, j) > grad(i + 1, j - 1)) || (grad(i, j) > grad(i, j + 1) && grad(i, j) > grad(i, j - 1)) || (grad(i, j) > grad(i - 1, j) && grad(i, j) > grad(i + 1, j)))
                    canny(i,j) = grad(i, j);
                else
                    canny(i, j) = 0;
                end
            end
            if (sector(i, j) == 1) % 90度
                if (grad(i, j) > grad(i - 1, j) && grad(i, j) > grad(i + 1, j))
                    canny(i,j) = grad(i, j);
                else
                    canny(i, j) = 0;
                end
            end
            if (sector(i, j) == 2) % 135度
                if ((grad(i, j) > grad(i - 1, j - 1) && grad(i, j) > grad(i + 1, j + 1))|| (grad(i, j) > grad(i, j + 1) && grad(i, j) > grad(i, j - 1)) || (grad(i, j) > grad(i - 1, j) && grad(i, j) > grad(i + 1, j)))
                    canny(i,j) = grad(i, j);
                else
                    canny(i, j) = 0;
                end
            end
            if (sector(i, j) == 3) % 180度
                if (grad(i, j) > grad(i, j + 1) && grad(i, j) > grad(i, j - 1))
                    canny(i,j) = grad(i, j);
                else
                    canny(i, j) = 0;
                end
            end
        end
    end
end
