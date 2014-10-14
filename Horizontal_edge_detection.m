function [imageH] = Horizontal_edge_detection(imageH)

        
    imageH = edge(uint8(imageH),'sobel','horizontal');

end

