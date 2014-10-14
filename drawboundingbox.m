function g = drawboundingbox(image)
%DRAWBOUNDINGBOX draws the bounding boxes around the blobs in a binary image
% image is the binary image input supplied by the user. This function
% extracts the coordinates and dimension values of each blob from
% stats.BoundingBox structure one by one and draws the rectangle around
% them. To store an image you can further use IMWRITE function on the
% output of the function DRAWBOUNDINGBOX
% image = imread(image_name);
% image = im2bw(image,0.5);
%image = imcomplement(image);
[image1 num] = bwlabel(image);
imshow(image1)
stats = regionprops(image1, 'BoundingBox');
g = image;
[M N] = size(stats);
% stats(4).BoundingBox

for k = 1:M
    for i = floor(stats(k).BoundingBox(1))-1:floor(stats(k).BoundingBox(1))+stats(k).BoundingBox(3)+1
        for j = floor(stats(k).BoundingBox(2))-1:floor(stats(k).BoundingBox(2))+stats(k).BoundingBox(4)+1
            x1 = floor(stats(k).BoundingBox(1));
            y1 = floor(stats(k).BoundingBox(2));
            if(x1~=0)
                g(y1,i) = 0.6;
            g(y1+stats(k).BoundingBox(4),i) = 0.6;
            g(j,x1) = 0.6;
            g(j,x1+stats(k).BoundingBox(3)) = 0.6;
            end
        end
    end
end
imshow(g)
end