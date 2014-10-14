function Calculate_Bands(Vert_proj)

    global NUM_OF_PLATES;
    global detected_plates;
    global Cy;
    global SIZE_RANK_FILTER;
    
    
    start = floor(SIZE_RANK_FILTER/2);
    
    
    for i=1:NUM_OF_PLATES
            size(Vert_proj)
            [c ind] = max(Vert_proj);
            %ind
            var = ind-1;
            
            while(true && var>0)
                 if(Vert_proj(var) <= Cy * c)
                    detected_plates(i,3)= var+start; %%% start is added as in first phase image size reduces by start from all 4 sides
                                                     %%% size of imageV is (image - 2*start)                  
                    y0 = var
                    break;
                 end
                 var  = var-1;
            end
            
            var = ind+1;
            while(true && var<= size(Vert_proj,1))
                 if(Vert_proj(var) <=Cy*c)
                    detected_plates(i,4) = var+start; %%% start --- same reason %%%
                    y1 = var
                    break;
                end
                var = var + 1;
            end
            Vert_proj(detected_plates(i,3)-start:detected_plates(i,4)-start) = 0;
    end
    
    
    


end

