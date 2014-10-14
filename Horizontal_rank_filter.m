function [ ] = Horizontal_rank_filter(image,Size)

    
    global SIZE_IMAGE;
    global imageH;
        
    start = floor(size/2);

    imageH = zeros(SIZE_IMAGE-2*start);
    
    for row = (start+1):(SIZE_IMAGE(1)-start)
        for col=(start+1):(SIZE_IMAGE(2)-start)
            for j=-start:start
                imageH(row-start,col-start)= imageH(row-start,col-start)+ double(image(row,col+j)*(1/size)); 
            end
        end
    end
    


end

