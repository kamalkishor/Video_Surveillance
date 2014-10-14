function [Hor_proj] = Horizontal_Projection(image,Size,index,image2)

    global detected_plates;
    global Cx

    sumH = sum(image,1); %%%% horizontal projection %%%%%%
    subplot(3,1,2),plot(sumH);
    
    %%% Apply rank filter to correct ragged graph
    size_image = size(image);
    
    Hor_proj = zeros(1,size_image(2));
   
    start = floor(Size/2);
       
    for i=(start+1):(size_image(2))-start
       for j=-start:start
              Hor_proj(i) = Hor_proj(i) + double(sumH(i+j)*(1/Size));
       end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    
    
    [c ind] = max(Hor_proj);
    var = ind-1;
    
    while(true && var>0)
        if(Hor_proj(var) <= Cx * c)
            detected_plates(index,1)= var;
            %y0 = var
            break;
        end
        var  = var-1;
    end
    
    var = ind+1;
    while(true && var<= size(Hor_proj,2))
        if(Hor_proj(var) <=Cx*c)
            detected_plates(index,2) = var;
           % y1 = var
            break;
        end
        var = var + 1;
    end
    
    subplot(4,1,1), imshow(image2);
    subplot(4,1,2), imshow(image);
    subplot(4,1,3), plot(Hor_proj);
    subplot(4,1,4), imshow(image2(:,detected_plates(index,1):detected_plates(index,2)));
    input('next');

end

