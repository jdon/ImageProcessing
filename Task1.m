% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

% Step-1: Load input image
I = imread('Zebra.jpg');
figure;
imshow(I);
title('Step-1: Load input image');

% Step-2: Conversion of input image to grey-scale image
Igray = rgb2gray(I);
figure;
imshow(Igray);
title('Step-2: Conversion of input image to greyscale');

% and following steps

% get size of inputted image
[orgHeight,orgWidth] = size(Igray);

% set new height and width
newHeight = 1836;
newWidth = 1668;

% work out how much to scale image
HeightScaleFactor = newHeight/orgHeight;
WidthScaleFactor = newWidth/orgWidth;

% create new image, matrix filled with zeros
NNImage(1:newHeight,1:newWidth)= 0;

% loop through height and width of new image
for h = 1:newHeight
    for w = 1:newWidth
        % get what pixel x,y to use on new image
        pixelLocationH = round(h/HeightScaleFactor);
        pixelLocationW = round(w/WidthScaleFactor);
        % if rounded to zero, change to 1, as matlab is based on 1 index
        if pixelLocationH == 0
            pixelLocationH = 1;
        end
        if pixelLocationW == 0
            pixelLocationW = 1;
        end
        % get value from image
        pixelValue = Igray(pixelLocationH,pixelLocationW);
        % set value to new image
        NNImage(h,w) = pixelValue;
    end
end
% conver to image and display it
nn = mat2gray(NNImage);
figure;
imshow(nn);
title('Step-3: NN interpolation');
