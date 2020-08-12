clear all
mycam = webcam;
mycam.Resolution='320x240';
img = snapshot(mycam);
saveas(gcf,'handler/train/Red/ImageRedFinal3','jpg')
figure(1)
imshow(img)
% saveas(gcf,'ImageRedFinal1','jpg')

% load HSV_orange.mat
% load HSV_purple.mat
% load HSV_yellow.mat
% load HSV_red.mat
% t_red = 0.005;
% t_yellow = 0.01;
% t_purple = 0.035; %0.03
% t_orange = 0.01;
% 
% CD = colorDetectHSVimage(img, HSV_red, t_red);
% figure(2)
% imshow(CD)
%     CDfiltered = bwareaopen(CD, 100);
%     figure(3)
%     imshow(CDfiltered)
% 
%     % Fill image
%     CDfilled = imfill(CDfiltered, 'holes');
%     figure(4)
%     imshow(CDfilled)
% 
%     % Label connected components
%     L = bwlabel(CDfilled);
% 
%     % Calculate region properties for connected components
%     s = regionprops(L);
% 
%     % Concatenate an array of all the region's 'area' values
%     areas = cat(1, s.Area);
%     [value, index1] = sort(areas);
% 
% % 

