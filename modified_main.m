%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ME 598
% Final Project
%
% Use navigation and localization to locate landmarks, decipher a code, and
% recite the code, by using sensor/image processing, odometry, and
% geometric relationship
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%

% HSV and threshold values initialization
clear
load HSV_orange.mat
load HSV_purple.mat
load HSV_yellow.mat
load HSV_red.mat
t_red = 0.005;
t_yellow = 0.01;
t_purple = 0.035; %0.03;
t_orange = 0.01;

% Robot Initialization
robotPort = 9;
[serialObject] = RoombaInit(robotPort,'full')

% Camera Initialization 
mycam = webcam;
mycam.Resolution='320x240';

% Beep 
BeepRoomba(serialObject)
pause(10)

BeepRoomba(serialObject)
pause(0.5)
BeepRoomba(serialObject)
pause(0.5)
%%
%%%%%%%%%%%%%% Trial %%%%%%%%%%%%%%

% Read encoders (provides baseline)
[StartLeftCounts, StartRightCounts] = EncoderSensorsRoomba(serialObject); 

iRobotTurnToCone(serialObject, mycam, HSV_red,t_red,200); %find red cone

iRobotTurn(serialObject, -88.4); %turn 90 degrees

% Navigation to the purple/yellow cones
length = 4;
iRobotStopAtCliff(serialObject,length); %stop when black line is detected

iRobotTurn(serialObject, -88.4); % turn 90 CW
 
length = 2.5;
iRobotFollowCliff2(serialObject, length); %follow black line to the cones

length = 4;
iRobotStopAtCliff(serialObject,length); %stop when black line ends

iRobotTurn(serialObject, -110); %turn to see the purple/yellow cones
pause(1);

SetFwdVelRadiusRoomba(serialObject, 0.1, 0); %all the cones in the FOV
pause(0.3);

% Decoder
img = snapshot(mycam); %acquire images
yellow = colorDetectHSVimage(img, HSV_yellow, t_yellow);  %detect any yellow cones
purple = colorDetectHSVimage(img, HSV_purple, t_purple);  %detect any yellow cones
binaryvect = getBinary(yellow, purple) %get the binary code 

iRobotTurn(serialObject, -155);
pause(1);

% Going home
length = 2;
iRobotStopAtCliff2(serialObject,length); %detect black line

iRobotTurn(serialObject, 88.4); %turn CCW
pause(1);

length = 2.5;
iRobotFollowCliff3(serialObject, length); %follow the black line

iRobotTurnToCone2(serialObject, mycam, HSV_red,t_red,50); %turn & find red cone

iRobotGoToCone2(serialObject, mycam, HSV_red, t_red, 90); %drives to red cone

% Binarybeep
binarybeep(serialObject, binaryvect);

% Celebrate
for i = 1:3
    SetFwdVelAngVelRoomba(serialObject, 0, pi/2);
    pause(4);
    SetFwdVelAngVelRoomba(serialObject, 0, 0);
    pause(0.1);
end

%%%%%%%%%%%%%% End %%%%%%%%%%%%%%
SetFwdVelRadiusRoomba(serialObject, 0, 0);
PowerOffRoomba(serialObject)
