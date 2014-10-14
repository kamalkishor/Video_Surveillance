function [] = Vertical_rank_filter(image,Size)


    global SIZE_IMAGE;
    global imageV;
    
    
    start = floor(Size/2);
    
    imageV = zeros(SIZE_IMAGE-2*start);

     for col = (start+1):SIZE_IMAGE(2)-start
        for row=(start+1):SIZE_IMAGE(1)-start
            for j=-start:start
                imageV(row-start,col-start)= imageV(row-start,col-start)+ double(image(row+j,col)*(1/Size)); 
            end
        end
     end
    


end

