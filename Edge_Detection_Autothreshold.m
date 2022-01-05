function output_image = Edge_Detection_Autothreshold(I)

    Igray = rgb2gray(I);
    threshold = generate_threshold(Igray)
    output_image = edge(Igray, 'Canny', threshold);
    
end
  