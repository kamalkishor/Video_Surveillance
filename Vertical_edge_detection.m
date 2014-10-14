function [imageV] = Vertical_edge_detection(imageV)

    %%%%%% sobel filter is used -- vertical %%%%%%%%%

      
    imageV= edge(uint8(imageV),'sobel','vertical');

end

