%% ME 598, Lecture 7


%% Color detection demo
clear all
close all
clc

% STEP 1: Use getHSVColorFromDirectory(dirName) in order to estimate the
% average HSV values of your objects of interest.
load HSV_orange.mat

% STEP 2: Use the estimated (average) hsv value for detecting the specified
% color in a specific image.
% if size(HSV,1)>1
%     colorDetectHSV('test/ballsUpsideDown.JPG', median(HSV), [0.05 0.05 0.2]);
% else
%     colorDetectHSV('test/ballsUpsideDown.JPG', HSV, [0.05 0.05 0.2]);
% end
image = imread('handler/Imagetest.jpg');
CD = colorDetectHSVimage(image, HSV_orange, 0.01);
%%

%% Blob Analysis Demo
% clear all
% close all
% clc

% Read image into MATLAB
%CD = imread('test/blob.bmp');
figure(1)
imshow(CD)
title('Original BW')

% Open image by removing connected pixel regions less than 200 pixels in
% size
CDfiltered = bwareaopen(CD, 200);
figure(2)
imshow(CDfiltered)
title('Opened')

% Fill image
CDfilled = imfill(CDfiltered, 'holes');
figure(3)
imshow(CDfilled)
title('Opened + Filled')

% Label connected components
L = bwlabel(CDfilled);
[rows, colums, ~] = size(CDfilled)
% Calculate region properties for connected components
s = regionprops(L);

% Concatenate an array of all the region's 'area' values
areas = cat(1, s.Area);

% Concatenate an array of all the region's 'centroid' values
centroids = cat(1, s.Centroid);

% Identify largest area
max_area = max(areas);

% Find the index in the 'areas' array corresponding to max_area
idx = find(areas == max_area);

% Get the centroid value for the region with the largest area
centroidX = centroids(idx,1);
centroidY = centroids(idx,2);

% Select the connected component corresponding to this region
BW2 = ismember(L, idx);

% Plot the image of the largest connected region
figure(4)
imshow(BW2)
hold on

% Plot a blue star in centroid of region
plot(centroidX, centroidY, 'b*')