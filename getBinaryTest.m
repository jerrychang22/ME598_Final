clear
img = imread('train/FourConesWPurple.jpg');

load HSV_orange.mat
load HSV_purple.mat
load HSV_yellow.mat
load HSV_red.mat
t_red = 0.005;
t_yellow = [0.01 0.05 0.05];
t_purple = 0.03;
t_orange = 0.01;
yellow = colorDetectHSVimage(img, HSV_yellow, t_yellow);
purple = colorDetectHSVimage(img, HSV_purple, t_purple);
[binary] = getBinary(yellow, purple)

