function [ image1,image_new2 ] = find_skew_angle( image )

  global SKEW_THRESHOLD;
   
    
    [height width] = size(image);
    
%     imshow(image);
%     input('asdf');
    
    
    %image = Horizontal_edge_detection(image);
    image1 = image;
    image = edge(image,'sobel',0.1,'horizontal');
    
    %subplot(1,2,1), imshow(image);
    
    image_new = zeros(height,width);
    
    
    for col=1:width     %%%%% x
        x1 = 2*(col/ width) - 1;
        for row=1:height %%%%%  y
            y1 = 2*(row/height) - 1;
           for a=1:width
                
                a1 = 2*(a/width)-1;
                b1 = y1- a1*x1;
                b = int16((b1+1)*height)/2;
                
                if(b>0 && b<=height)
                image_new(b,a) = image_new(b,a) + image(row,col); %% reversed as x -- is col
                end
           end
        
        end
    end
    
       % subplot(1,2,2), imshow(uint8(image_new));
    
    %%%%%%% Calculate Max indices in image_new array %%%%%%%%%%
    
        [max_arr , row_arr] = max(image_new);
        [maxValue ,a] = max(max_arr);
            b = row_arr(a);
        
        a
        th=atan(a)
        
        
         a1 = 2*(a/width)-1;
         b1 = 2*(b/height)-1;
        
        x01 = 2*(1/width) -1;
        x11 = 1;
        
        
        
        y01 = a1*x01 + b1;
        y11 = a1*x11 + b1;
        
        y0 = (y01+1)*height/2;
        y1 = (y11+1)*height/2;
         
        
        dy = y1-y0;
        dx = width;
        ang1 = dy/dx; %%% tan(th)
        
        ang = 180*atan(dy/dx)/pi %%% angle in degree
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%% deskewing image %%%%%%%
    
    %%%% deskewing done if |angle| > SKEW_THRESHOLD
    
     %%% center co-ordinate ======  (h/2 , w/2)
     
     if(abs(ang) > SKEW_THRESHOLD)
         
         image_new2 = zeros(height,width);
         
         Cx = width/2; %%%% ------------ x-axis i.e col
         Cy = height/2; %%%% y-axis -- vertical downwards  i.e row
         
         for row=1:height
             for col=1:width
                 row1 = row - Cy;
                 col1 = col - Cx;
                 row1 = row1 - col1*ang1;
                 row1 = uint8(row1 + Cy);
                 if(row1>0 && row1<=height)
                     image_new2(row1,col) = image1(row,col);
                 end
             end
         end
         subplot(4,1,4), imshow(uint8(image_new2));
     else
         subplot(4,1,4), imshow(uint8(image1));
         image_new2 = image1;
     end
     
     title_na = strcat('Skewed angle: ',num2str(ang),'(degrees)');
     title(title_na);
     
     
     image1 = uint8(image1);
     image_new2 = uint8(image_new2);
     
     
     
     subplot(4,1,1), imshow(uint8(image1));
     subplot(4,1,2), imshow(image);
     subplot(4,1,3), imshow(uint8(image_new));
     
     
    
     
    


end
