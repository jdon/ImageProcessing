% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;
%Step-1: Load input image
I = imread('Noisy.png');
% Step-2: Conversion of input image to grey-scale image
Igray = rgb2gray(I);
%get image height and width
[orgHeight,orgWidth] = size(Igray);
%pad array with 5 to each side
paddedArray = padarray(Igray, [5 5]);
% create blank matrix for mean and median
MeanImage(1:orgHeight,1:orgWidth)= 0;
MedianImage(1:orgHeight,1:orgWidth)= 0;
%loop though image ignore the padding
for h = 6:orgHeight+5
    for w = 6:orgWidth+5
        % get the neighbouring pixels, two between and two infront of each
        % pixel = 5*5 kernel
        neighbours = paddedArray( h-2:h+2, w-2:w+2 );
        % get the mean value of the neighbours
        Meanvalue = mean2(neighbours);
        % get the median value of the neighbours
        Medianvalue = median(neighbours(:));
        % set the new matrix to the new value
        MeanImage(h-5,w-5) = Meanvalue;
        MedianImage(h-5,w-5) = Medianvalue;
    end
end
% display the images
mean = mat2gray(MeanImage);
media = mat2gray(MedianImage);
subplot(1,3,1), imshow(Igray)
title('Noisy')
subplot(1,3,2), imshow(media)
title('Median')
