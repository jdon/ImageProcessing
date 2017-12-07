% MATLAB script for Assessment Item-1
% Task-4
clear; close all; clc;
%Step-1: Load input image
I = imread('Starfish.jpg');
% Step-2: Conversion of input image to grey-scale image
I = rgb2gray(I);
% Convert the image to binary
binary = imbinarize(I,0.90);
% complement the image
Ic = imcomplement(binary);
% remove noise from image, using median filter
med = medfilt2(Ic,[5 5]);
% get region stats for each potential region
stats = regionprops(med,'Area','Perimeter','Extent');
area = [stats.Area];
Perimeter = [stats.Perimeter];
Extent = [stats.Extent];
% calculate roundness for each potential region
roundness  = 4*pi*area./Perimeter.^2;
% labels each potential region in the image using 8-connected component labelling
labelimage = bwlabel(med);
subplot(2,3,1), imshow(med)
title('Median')
% find function is used on the area and roundness values from the potential 
% regions, to find value which fit inside the thresold
startObjects = find(roundness  <0.3 & roundness  >0.2);
I = ismember(labelimage,startObjects);
subplot(2,3,2), imshow(I)
title('roundness  <0.3 & roundness  >0.2')
startObjects = find(area >1150 & area <1390);
I = ismember(labelimage,startObjects);
subplot(2,3,3), imshow(I)
title('area >1150 & area <1390  ')
startObjects = find(roundness  <0.3 & roundness  >0.20 & area >1150 & area <1390);
I = ismember(labelimage,startObjects);
subplot(2,3,4), imshow(I)
title('roundness  <0.3 & roundness  >0.20 & area >1150 & area <1390')
startObjects = find(Extent < 0.4);
I = ismember(labelimage,startObjects);
subplot(2,3,5), imshow(I)
title('Extent < 0.4')
startObjects = find(Extent < 0.4 & area >1150 & area <1390);
I = ismember(labelimage,startObjects);
subplot(2,3,6), imshow(I)
title('Extent < 0.4 & area >1150 & area <1390');
