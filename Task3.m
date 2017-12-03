% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;
%Step-1: Load input image
I = imread('Noisy.png');
% Step-2: Conversion of input image to grey-scale image
Igray = rgb2gray(I);
[orgHeight,orgWidth] = size(Igray);
paddedArray = padarray(Igray, [5 5]);
MeanImage(1:orgHeight,1:orgWidth)= 0;
MedianImage(1:orgHeight,1:orgWidth)= 0;


for h = 6:orgHeight+5
    for w = 6:orgWidth+5
        neighbours = paddedArray( h-2:h+2, w-2:w+2 );
        Meanvalue = mean2(neighbours);
        Medianvalue = median(neighbours(:));
        MeanImage(h-5,w-5) = Meanvalue;
        MedianImage(h-5,w-5) = Medianvalue;
    end
end
nI = mat2gray(MeanImage);
figure;
imshow(nI);
title('Mean Image');
medi = mat2gray(MedianImage);
figure;
imshow(medi);
title('Median Image');