function [ thresh_image ] = Plate_segmentation(imageName)
    
   %%%% image -- detected plate image %%%%
   
   close all;
   %%% Step 1)  Adaptive Thresholding -- binary image %%%%%%
   
   image = imread(imageName);
    size_image = size(image);
       a  = 50/size_image(1);
    image = imresize(image,a);   
       
       
   thresh_image = AdaptiveThresholding(image,10,7); %%% return thresholded (adaptive) image %%%
                                                    %%% it is a binary image %%%%%%                    
   
   
                                                    
   thresh_image = CCA(thresh_image);   
   size(thresh_image)
   input('dsafa');
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% *********** 
%    %%%%%%%%%%%%%%% Horizontal projection %%%%%%%%%%%%%%%
%    
%         Hor_proj = sum(thresh_image,1);  %% 1 - adding col wise %%%
% %         hold on;
% %        % subplot(2,2,1),imshow(image);
% %         hold on; subplot(2,2,2),imshow(thresh_image); hold on;
% %         subplot(2,2,2),plot(Hor_proj,'r');
% %         subplot(2,2,1),plot(Hor_proj,'r');
% % %         subplot(2,2,3),imshow(thresh_image2);
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%         subplot(2,1,1) , imshow(thresh_image);
%         %subplot(2,1,2) ,plot(Hor_proj);
%         subplot(2,1,2,'replace');
%      %%%%%%%%%% Segmentation %%%%%%%
%      peaks = ones(1,20);
%      width = size(image,2);
%      height = size(image,1);
%      
%      Segment_Cx = 0.7;
%      Segment_Cw = 0.86;
%      
%      lines = zeros(1,width);
%      
%      [max_value] = max(Hor_proj); 
%      max_thresh = Segment_Cw * max_value;
%      i=1;
%      
%      while(true)
%          x1 = 1;
%          x2 = width;
%          [value x] = max(Hor_proj); 
%          if(value > max_thresh)
%              %x
%             peaks(1,i)= x;
%             lines(1,x) = height;
%             val = x-1;
%             while(true && val>0)
%                
%                 if(Hor_proj(val)< Segment_Cx * value)
%                     x1 = val
%                     break;
%                 end
%                 val = val-1;
%             end
%             
%             val = x+1;
%             while(true && val<width)
%                 
%                 if(Hor_proj(val)< Segment_Cx * value)
%                     x2 = val
%                     break;
%                 end
%                 val = val+1;
%             end
%          else    
%             break;
%          end
%          
%          %input('adsf');
%          i=i+1; 
%          Hor_proj(1,x1:x2)=0;
%      end
%      
%      peaks(1,1:i-1)
%      imshow(image);
%      hold on;
% %      plot(Hor_proj,'r'); hold on
% 
%     for i=1:i-1
%      plot([peaks(1,i) peaks(1,i)],[1 height],'r','LineWidth',4);
%      hold on;
%     end
%         
end

