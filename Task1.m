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
        w1 = 3*(floor((w-1)/3))+1;
        w2 = 3*(ceil((w-1)/3))+1;
        h1 = 3*(ceil((h-1)/3))+1;
        h2 = 3*(floor((h-1)/3))+1;
        currentcords = [h,w];
        bottomleftcords=[h1,w1];
        topleftcords=[h2,w1];
        bottomrightcords=[h1,w2];
        toprightcords=[h2,w2];
        
        bottomleft=upscaledValues(h1,w1);
        topleft=upscaledValues(h2,w1);
        bottomright=upscaledValues(h1,w2);
        topright=upscaledValues(h2,w2);
        
        distLeft = w -topleftcords(2);
        distRight = toprightcords(2) -w;
        test = w2-w;
        test1 = w2-w1;
        tes2 = test/test1;
        topleftscale = topleft*tes2;
        bottomleftscale = bottomleft * tes2;
        
        test3 = w -w1;
        test4 = w2-w1;
        test5 = test3/test4;
        toprightscale = topright*test5;
        botrightscale = bottomright * test5;
        
        topValue = topleftscale +toprightscale;
        bottomValue = bottomleftscale +botrightscale;
        
        %leftValue = ((h2 - h)/(h2 - h1))*topleft + ((h - h1)/(h2 - h1))*topright;
        %bilinear = ((h2 - h)/(h2 - h1))*topValue + ((h - h1)/(h2 - h1))*bottomValue;
        %BiImage(h,w) = bilinear;
        %upscaledValues(h,w) = bilinear;
        if(isequal(bottomleftcords,currentcords)||  isequal(bottomrightcords,currentcords)||  isequal(toprightcords,currentcords)||  isequal(topleftcords,currentcords))
        else
            %upscaledValues(h,w) = bilinear;
            if(isequal(bottomleftcords,topleftcords)&&  isequal(bottomrightcords,toprightcords))
                %do linear on top values
                upscaledValues(h,w) = topValue;
            end
            if(isequal(bottomleftcords,bottomrightcords)&&  isequal(topleftcords,toprightcords))
                %do linear on left values
                %upscaledValues(h,w) = leftValue;
            end
            if (isnan(topValue))
            else
                %BiImage(h,w) = topValue;
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
        topValue = upscaledValues(topH,w);
        bottomValue = upscaledValues(bottomH,w);
        if(h ~= topH || h ~= bottomH)
            topish = (topH - h)/(topH-bottomH)*bottomValue;
            bottomish = (h-bottomH)/(topH-bottomH)*topValue;
            upscaledValues(h,w) = topish + bottomish;
        end
        
    end
end

for h = 1:newHeight
    for w = 1:newWidth
        
    end
end
%gg = GetBilinearPixel(Igray,250,500);
% conver to image and display it
nn = mat2gray(NNImage);
figure;
imshow(nn);
title('Nearest Neighbour');
ups = mat2gray(upscaledValues);
figure;
imshow(ups);
title('BiImage interpolation');
bi = mat2gray(BiImage);
figure;
imshow(bi);
title('Step-3: BiImage interpolation');

