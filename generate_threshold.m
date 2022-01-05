function threshold = generate_threshold(I)
     C = 0.25;
     threshold_low = max(1,C*(mean2(I)-std2(I)))/255;    
     threshold_high = min(254,C*(mean2(I)+std2(I)))/255;
     threshold = [threshold_low threshold_high];
end