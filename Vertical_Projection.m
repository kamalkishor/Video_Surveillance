function [Vert_proj] = Vertical_Projection(imageV,Size)

    global SIZE_IMAGEV;
   

    sumV = sum(imageV,2); %%%% vertical projection %%%%%%
    
       
    %%% Apply rank filter to correct ragged graph
    SIZE_IMAGEV = size(imageV);
    
    Vert_proj = zeros(SIZE_IMAGEV(1),1);
   
    start = floor(Size/2);
       
    for i=(start+1):(SIZE_IMAGEV(1))-start
       for j=-start:start
              Vert_proj(i) = Vert_proj(i) + double(sumV(i+j)*(1/Size));
       end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end

