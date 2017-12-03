% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;
% Step-1: Load input image
Igray = imread('SC.png');
% Step-2: Conversion of input image to grey-scale image
%Igray = rgb2gray(I);
[orgHeight,orgWidth] = size(Igray);

NewImage(1:orgHeight,1:orgWidth)= 0;
for h = 1:orgHeight
    for w = 1:orgWidth
        pixelvalue = Igray(h,w);
        if (pixelvalue >= 80 && 100 <= pixelvalue)
            NewImage(h,w) = 220;
        else
            NewImage(h,w) = pixelvalue;
        end
    end
end
% conver to image and display it
figure;
imshow(Igray);
title('Old Image');
nI = mat2gray(NewImage);
figure;
imshow(nI);
title('New Image');



