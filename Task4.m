% MATLAB script for Assessment Item-1
% Task-4
clear; close all; clc;
%Step-1: Load input image
I = imread('Starfish.jpg');
% Step-2: Conversion of input image to grey-scale image
I = rgb2gray(I);
I = imbinarize(I,0.90);
I = medfilt2(I,[5 5]);

I = imcomplement(I);

labelimage = bwlabel(I);
stats = regionprops(I,'Area','Perimeter','Extent');
area = [stats.Area];
Perimeter = [stats.Perimeter];
Extent = [stats.Extent];
roundness  = 4*pi*area./Perimeter.^2;
%circularities = [stats.Perimeter].^2./(4*pi*[stats.Area]);
%startObjects = find(roundness  <0.45 & area <1390 & area >1150 & roundness  >0.20);
startObjects = find(Extent < 0.4 & area >1150 & roundness  >0.20);
%startObjects = find(Extent < 0.4);
%startObjects = find(roundness  <5 & roundness  >3.9406 & [stats.Area] >1150);
I = ismember(labelimage,startObjects)>0;
figure;
imshow(I);
title('Star Image');
