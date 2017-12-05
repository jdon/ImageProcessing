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
newHeight = 1668;
newWidth = 1836;

% work out how much to scale image
HeightScaleFactor = newHeight/orgHeight;
WidthScaleFactor = newWidth/orgWidth;
disp(HeightScaleFactor);
disp(WidthScaleFactor);

Igraypadded = padarray(Igray,[1 1],'symmetric');

% create new image, matrix filled with zeros
NNImage(1:newHeight,1:newWidth)= 0;

BiImage(1:newHeight,1:newWidth)= 0;
upscaledValues(1:newHeight,1:newWidth)= 0;
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
for h = 1:orgHeight
    for w = 1:orgWidth
        upscaledValues((3*h)-2,(3*w)-2) = Igray(h,w);
    end
end
upscaledValuesPadded = padarray(upscaledValues,[1 1],'symmetric');
upscaledValues = upscaledValuesPadded(2:newHeight+2,2:newWidth+2);
%loop though new image and put where zebra is
for h = 1:newHeight
    for w = 1:newWidth
        x1 = 3*(floor((w-1)/3))+1;
        x2 = 3*(ceil((w-1)/3))+1;
        y1 = 3*(ceil((h-1)/3))+1;
        y2 = 3*(floor((h-1)/3))+1;
        
        q11=upscaledValues(y1,x1);
        q12=upscaledValues(y2,x1);
        q21=upscaledValues(y1,x2);
        q22=upscaledValues(y2,x2);
        
        
        BiImage(h, w) = GetBilinearPixel(q11, q12,q21, q22, x1, x2, y1, y2, h, w);
       
    end
    
end

%gg = GetBilinearPixel(Igray,250,500);
% conver to image and display it
nn = mat2gray(NNImage);
figure;
imshow(nn);
title('Step-3: Upscaled');
ups = mat2gray(upscaledValues);
figure;
imshow(ups);
title('Step-3: BiImage interpolation');
bi = mat2gray(BiImage);
figure;
imshow(bi);
title('Step-3: BiImage interpolation');
disp(GetBilinearPixel(3,1,4,2,1,2,1,2,1,1));
function [P] = GetBilinearPixel(q11, q12,q21, q22, x1, x2, y1, y2, h, w)
    if(mod(x1,3) == 0 && mod(x2,3) == 0 &&mod(y1,3) == 0 && mod(y2,3) == 0)
        %every cord given is ready so do bilinear
    end
    % used
    % http://supercomputingblog.com/graphics/coding-bilinear-interpolation/
    % as ref
        R1 = q11/2 + q21/2;
        R2 = q12/2 + q22/2;
        P = R1 + R2;
end
