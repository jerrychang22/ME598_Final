clear all
close all
clc

% HSV_red = getHSVColorFromDirectory('handler/train/Red');
% save HSV_red.mat HSV_red

% img = imread('ImageRedF.JPG');
% hsv_image = rgb2hsv(img) ;


load HSV_red-orig.mat
img = imread('untitled.JPG');
figure(1)
imshow(img)
img_HSV = rgb2hsv(img);
% figure(2)
% imshow(HSV)
I = colorDetectHSVimage('handler/train/Red/untitled.jpg', HSV_red, [0.005 0.2 0.2]);
%figure(2)
%imshow(I)


    Ifiltered = bwareaopen(I, 100);
    figure(3)
    imshow(Ifiltered)

    % Fill image
    Ifilled = imfill(Ifiltered, 'holes');
    figure(4)
    imshow(Ifilled)
%{
    % Label connected components
    L = bwlabel(Ifilled);

    % Calculate region properties for connected components
    s = regionprops(L);

    % Concatenate an array of all the region's 'area' values
    areas = cat(1, s.Area);
    [value, index1] = sort(areas);
%}
    

