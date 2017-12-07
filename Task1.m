% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

I = imread('Zebra.jpg');
Igray = rgb2gray(I);

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
BiLinear(1:newHeight,1:newWidth)= 0;
% loop through height and width of new image
tic;
for h = 1:newHeight
    for w = 1:newWidth
        % get what pixel x,y to use on new image
        pixelLocationH = ceil(h/HeightScaleFactor);
        pixelLocationW = ceil(w/WidthScaleFactor);
        % get value from original image
        pixelValue = Igray(pixelLocationH,pixelLocationW);
        % set value to new image
        NNImage(h,w) = pixelValue;
    end
end
disp("NN Time "+toc);
tic;
for h = 1:orgHeight
    for w = 1:orgWidth
        % set pixels from old image into new image
        BiLinear((3*h)-2,(3*w)-2) = Igray(h,w);
    end
end
%pad the new bilinear image 
BiLinearPadded = padarray(BiLinear,[1 1],255);
%change the padded image, so that right and bottom of image is padded
BiLinear = BiLinearPadded(2:newHeight+2,2:newWidth+2);
%loop though the bilinear image and perform linear interpolation on the top
%and bottom of each unknown 9*9
for h = 1:newHeight
    for w = 1:newWidth
        % get the four points where the pixels from the small image are in
        % the new larger image
        w1 = 3*(floor((w-1)/3))+1;
        w2 = 3*(ceil((w-1)/3))+1;
        h1 = 3*(ceil((h-1)/3))+1;
        h2 = 3*(floor((h-1)/3))+1;
        %creat cords for the four corners
        currentcords = [h,w];
        
        bottomleftcords=[h1,w1];
        topleftcords=[h2,w1];
        bottomrightcords=[h1,w2];
        toprightcords=[h2,w2];
        %get the pixel values for the top corners
        topleft=BiLinear(h2,w1);
        topright=BiLinear(h2,w2);
        % get the distance from the current pixel to pixels in the original
        % 
        distLeft = w -topleftcords(2);
        distRight = toprightcords(2) -w;
        % work out what weighting to use for each pixel from the original
        % image
        leftScale = (w2-w)/(w2-w1);
        rightScale = (w -w1)/(w2-w1);       
        %Work out weighting of the left and right corners in regards to the
        %postion of the current pixel
        leftValue = topleft*leftScale;
        rightValue = topright*rightScale;
        
        value = leftValue +rightValue;
        % only set the values in the new image, if they are not going to
        % overlap the original values
        if(isequal(bottomleftcords,currentcords)||  isequal(bottomrightcords,currentcords)||  isequal(toprightcords,currentcords)||  isequal(topleftcords,currentcords))
        else
            if(isequal(bottomleftcords,topleftcords)&&  isequal(bottomrightcords,toprightcords))
                % only set the values in the new image, if they are not going to
                % overlap the original values
                BiLinear(h,w) = value;
            end
        end
        
    end
    
end

for h = 1:newHeight
    for w = 1:newWidth
        bottomH = 3*(ceil((h-1)/3))+1;
        topH = 3*(floor((h-1)/3))+1;
        
        topCord = [topH,w];
        bottomCord = [bottomH,w];
        topValue = BiLinear(topH,w);
        bottomValue = BiLinear(bottomH,w);
        
        if(h ~= topH || h ~= bottomH)
            topish = (topH - h)/(topH-bottomH)*bottomValue;
            bottomish = (h-bottomH)/(topH-bottomH)*topValue;
            BiLinear(h,w) = topish + bottomish;
        end
        
    end
end
BiLinear = BiLinear(1:newHeight,1:newWidth);
disp("Bilinear Time"+toc);
%gg = GetBilinearPixel(Igray,250,500);
% conver to image and display it
nn = mat2gray(NNImage);
ups = mat2gray(BiLinear);
subplot(1,2,1), imshow(nn)
title('Nearest Neighbour')
subplot(1,2,2), imshow(ups)
title('Bilinear')

