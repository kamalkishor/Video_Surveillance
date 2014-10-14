function [] = detect_plate(imageName)
    tic();
    
    close all;
    
    global image;
    global SIZE_IMAGE;
    global SIZE_RANK_FILTER;
    global SIZE_PRO_RANK_FILTER;
    global SIZE_HOR_PRO_RANK_FILTER;
    global SKEW_THRESHOLD;
    global ADAPTIVE_THRESHOLD_WINDOW_SIZE;
    global ADAPTIVE_THRESHOLD_CONST;
    global SIZE_IMAGEV;
    global imageH;
    global imageV;
    global detected_plates;
    global NUM_OF_PLATES;
    global Cy;
    global Cx;
    
    Cx = 0.42;
    Cy = 0.55;
    detected_plates = ones(NUM_OF_PLATES,4);
    NUM_OF_PLATES = 3;  
    SIZE_RANK_FILTER = 31;
    SIZE_PRO_RANK_FILTER = 31;
    SIZE_HOR_PRO_RANK_FILTER = 51;
    SKEW_THRESHOLD = 1.3; %% angle in degrees
    ADAPTIVE_THRESHOLD_WINDOW_SIZE = 10;
    ADAPTIVE_THRESHOLD_CONST = 7;
    
        image = imread(imageName);
    %%%%%% Converting to gray && resizing input image %%%%%%%%
        figure , imshow(image) , figure;
        image  = rgb2gray(image);
        r_size = 500 / size(image,1);
        image = imresize(image,r_size);  %% maintaining aspect ratio
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    SIZE_IMAGE = size(image);
       
    Vertical_rank_filter(image,SIZE_RANK_FILTER);  %%% this will update imageV %%%
%    subplot(2,5,2),imshow(uint8(imageV));
    
    imageV = Vertical_edge_detection(imageV);   
        
    Vert_proj = Vertical_Projection(imageV,SIZE_PRO_RANK_FILTER);
    
%     subplot(3,1,1), imshow(image);
%     subplot(3,1,2),imshow(imageV);
%     subplot(3,1,3),plot(Vert_proj);
     
%     input('Horizontal Projection');
    
%     subplot(2,5,1), imshow(image);
%     subplot(2,5,3),imshow(imageV);
%     subplot(2,5,5),plot(Vert_proj);
%     
    Calculate_Bands(Vert_proj);
    
    start = floor(SIZE_RANK_FILTER/2);
    
    for i=1:3
%         subplot(3,1,i), imshow(image(detected_plates(i,3):detected_plates(i,4),:))
        name = strcat('output/Step1/',int2str(i),'.jpg');
        imwrite(image(detected_plates(i,3):detected_plates(i,4),:),name);
    end
    input('Band Clipping');
   
%     
% %     for i=1:NUM_OF_PLATES
% %             find_skew_angle(image(detected_plates(i,3)+start:detected_plates(i,4)+start,:));
% %             input('next');        
% %     end



    for i=1:NUM_OF_PLATES
        
        x = Horizontal_edge_detection(image(detected_plates(i,3):detected_plates(i,4),:));
        Hor_proj = Horizontal_Projection(x,SIZE_HOR_PRO_RANK_FILTER,i,image(detected_plates(i,3):detected_plates(i,4),:));
        
        
        [image_skew image_deskewed] = find_skew_angle(image(detected_plates(i,3):detected_plates(i,4),detected_plates(i,1):detected_plates(i,2)));
        name1 = strcat('output/Step2/','deskewed_',int2str(i),'.jpg');
        name2 = strcat('output/Step2/','skewed_',int2str(i),'.jpg');
        imwrite(image_deskewed,name1);
        imwrite(image_skew,name2);
%          subplot(3,1,1),imshow(image(detected_plates(i,3):detected_plates(i,4),:));
%          subplot(3,1,2), imshow(x);
%          subplot(3,1,1),imshow(image(detected_plates(i,3):detected_plates(i,4),detected_plates(i,1):detected_plates(i,2)));
%          subplot(3,1,3),plot(Hor_proj);
         input('hi');
    end
    
    for i=1:2
        name = strcat('output/Step2/deskewed_',int2str(i),'.jpg');
        image_deskewed = imread(name);
        
        size_image = size(image_deskewed);
        a  = 30/size_image(1);
       image_deskewed = imresize(image_deskewed,a);
        
        
        thres_image = Plate_segmentation(image_deskewed);
        name = strcat('output/Step3/',int2str(i),'.jpg');
        imwrite(thres_image,name);
        input('next');
    end
    
    
    
    
    
    
    toc();

end

