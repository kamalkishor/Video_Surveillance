function [ thisBlob ] = CCA( binIm )

thL = 20;
%thH = 500;
width_ht_ratio = 1.35;
Height_threshold = 50/4;
size_image = size(binIm);




%doing CCA (connected component analysis)
cc = bwconncomp(imcomplement(binIm));       %Connected components

subplot(2,1,1), imshow(binIm);


% size(binIm);
% 
% labeled = labelmatrix(cc);  %The labeled matrix
% cc.ImageSize
% 
% 
% numPixels = cellfun(@numel,cc.PixelIdxList)
% 
% % oundingBox
%  %BW = imread('text.png');
%    s  = regionprops(cc, 'centroid');
%    centroids = cat(1, s.Centroid);
%    imshow(binIm)
%    hold on
%   plot(centroids(:,1), centroids(:,2), 'g*')
% 
% %   pause(100)
% 
% 
% 
% count = 0;
% for i=1:totalBlobs
%     if(numPixels(i)>thL && numPixels(i)<thH)
%         count = count +1;
%         index(count) = i;
%         
%     end
%     
% end
% 
% imshow(uint8(50*labeled));
% 
% input('mayank');
% 
% for i =index
%         thisBlob = labeled==i;
%         disp('size');
%        size(thisBlob)
%       imshow( thisBlob, [] );
%       input('next image');
% end
% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COde Starts %%%%%%%%%%%%%%%%%%%%%%%%%
%%% cc connected component %%%%%%
subplot(2,1,2)
numPixels = cellfun(@numel,cc.PixelIdxList);
labeled = labelmatrix(cc);  %The labeled matrix
totalBlobs = max(max(labeled));

count = 0;
for i=1:totalBlobs
    if(numPixels(i)>thL)
        count = count +1;
        index(count) = i;
    end
end

c = 1;
for i =index
    thisBlob = labeled==i;
    disp('size');
    size(thisBlob)
    
    stats = regionprops(thisBlob,'BoundingBox');
    stats
    value = stats(1).BoundingBox
    ratio = value(3)/value(4)
    if(ratio < width_ht_ratio && value(4)>Height_threshold)
        
        %drawboundingbox(thisBlob);
       imshow( thisBlob, [] );
        
        
%         input('msdafasdf');
%       
%          SE = strel('rectangle',[2 2]);
% %         
% %         input('dilate');
%         filled = imdilate(thisBlob,SE);
%         imshow(filled);
%         input('dsfdsaf');
%         BW2 = bwmorph(filled,'skel',Inf);
%         imshow(BW2);
% 
%         % %         input('erode');
% % %         eroded = imerode(filled,SE);
% % %         imshow(eroded);
% %         filled = imfill(thisBlob, 'holes');
%         imshow(filled);
            input('sdfasdf');
          r1 = max(round(value(2))-1,1);
          c1 = max(round(value(1))-1,1);
          c2 = min(round(value(1)+value(3)),size_image(2));
          r2 = min(round(value(2)+value(4)),size_image(1));
          image_char = thisBlob(r1:r2,c1:c2);
          
          imwrite(image_char,strcat('segmented_char/plate/',int2str(c),'.jpg'));
          c = c+1;
    end
    
    input('next image');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

