function [image_out] = AdaptiveThresholding( image,ADAPTIVE_THRESHOLD_WINDOW_SIZE,Const )

%global ADAPTIVE_THRESHOLD_WINDOW_SIZE;

%%% above image is gray scale image %%%%
    if(size(image,3)>1)
        image = rgb2gray(image);
    end
    
    mean_image = double(imfilter(image,fspecial('average',ADAPTIVE_THRESHOLD_WINDOW_SIZE),'replicate')) - Const;
    image_new = double(image) - mean_image;
    image_out = im2bw(image_new,0);
%     subplot(1,2,1),imshow(image);
%     subplot(1,2,2),imshow(image_out);



end

