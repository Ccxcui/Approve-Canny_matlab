function canny2 = dual_threshold_detection(canny, low_th, high_th)
    [m, n] = size(canny);
    canny2 = zeros(m, n);
    for i=2:m-1
        for j=2:n-1
            if (canny(i, j) < low_th)
                canny2(i,j) = 0;
            elseif (canny(i, j) > high_th)
                canny2(i, j) = canny(i, j);
            else
                neighbor_matrix = [canny(i-1, j-1), canny(i, j-1), canny(i+1, j-1);...
                                   canny(i-1, j), canny(i, j), canny(i+1, j);...
                                   canny(i-1, j+1), canny(i, j+1), canny(i+1, j+1);];
                max_neighbour = max(neighbor_matrix);
                if (max_neighbour > high_th)
                    canny2(i, j) = canny(i, j);
                else
                    canny2(i,j) = 0;
                end
            end
        end
    end
end
