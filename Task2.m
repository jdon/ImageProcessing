% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;
% Step-1: Load input image
Igray = imread('SC.png');
%get image height and width
[orgHeight,orgWidth] = size(Igray);

NewImage = Igray;
%loop though the image
for h = 1:orgHeight
    for w = 1:orgWidth
        pixelvalue = Igray(h,w);
        % set image value to 220 if pixel value is between 80 and 100
        if (pixelvalue >= 80 && pixelvalue <=100)
            NewImage(h,w) = 220;
        end
    end
end
% conver to image and display it
nI = mat2gray(NewImage);
subplot(1,2,1), imshow(Igray)
title('Before')
subplot(1,2,2), imshow(NewImage)
title('After')
figure;
%create histograms for both images
imhist(Igray);
figure;
imhist(NewImage);



