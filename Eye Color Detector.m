%----------o----------------o------------------o---------
% CENG 462 TERM PROJECT
% EYE COLOR DETECTION
% 201627015 MELİSA YILDIZ, 201611033 SELİN KARA
%-------------o---------------o-----------------o--------
% Load an image
I  = imread('brown.jpg');
%I= imread('hazel.jpg');
%I= imread('blue.jpg');
%I= imread('green.jpg');
I_gray = rgb2gray(I);
imageSize = size(I_gray);
imshow(I);

% Find all the circles with radius r pixels in the range [20, 1000].
[centers, radii, metric] = imfindcircles(I,[20 1000],'ObjectPolarity',"dark");

% Retain the strongest circle
centersStrong5 = centers(1:1,:); 
radiiStrong5 = radii(1:1);
metricStrong5 = metric(1:1);

% Draw the iris
%children function returns the parts of expression 'cd'
cd=viscircles(centersStrong5, radiiStrong5); 
c = cd.Children(1).XData(1:end-1);
r = cd.Children(2).YData(1:end-1);
% Create grid for mask
[C,R] = meshgrid(1:imageSize(2),1:imageSize(1));
%Find pts inside of circle
mask = inpolygon(R,C,r,c);
%to crop
croppedImage = uint8(zeros(imageSize));
croppedImage(:,:,1) = I(:,:,1).*uint8(mask);
croppedImage(:,:,2) = I(:,:,2).*uint8(mask);
croppedImage(:,:,3) = I(:,:,3).*uint8(mask);
imshow(croppedImage);

%to define color
%to find r,g,b values for low and high threshold values of colors
%mean2 function is used to find average or mean of cropped image in rgb
%round function is used to round each element of cropped image in rgb to the nearest integer.
R = round(mean2(nonzeros(croppedImage(:, :, 1))));
G = round(mean2(nonzeros(croppedImage(:, :, 2))));
B = round(mean2(nonzeros(croppedImage(:, :, 3))));
rgbImage(1, 1, :) = [R, G, B]; 

%according to the threshold values, print the color of eye
blue1 = 80; %low threshold
blue2 = 170; %high threshold
if (B > blue1 && B < blue2)
    disp("Color of this eye is: Blue");
    return
end


brown1 = 60; %low threshold
brown2 = 80; %high threshold
if (R >= brown1 && R < brown2)
    disp("Color of this eye is: Brown");
    return
end


green1 = 80; %low threshold
green2 = 100; %high threshold
if (G > green1 && G < green2)
    disp("Color of this eye is: Green");
    return
 
else
    disp("Color of this eye is: Hazel");
    return
end

disp("Color of this eye is not found!");
