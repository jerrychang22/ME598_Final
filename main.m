%% notice: now test everything after the beep
clear
load HSV_orange.mat
load HSV_purple.mat
load HSV_yellow.mat
load HSV_red.mat
t_red = 0.005;
t_yellow = 0.01;
t_purple = 0.03;
t_orange = 0.01;

%%
% Initialization
robotPort = 9;
[serialObject] = RoombaInit(robotPort,'full')

% Read encoders (provides baseline)
[StartLeftCounts, StartRightCounts] = EncoderSensorsRoomba(serialObject);

%camera initialization
mycam = webcam;
mycam.Resolution='320x240';

%%
%beep
% BeepRoomba(serialObject)
% pause(10)
% 
% BeepRoomba(serialObject)
% pause(0.5)
% BeepRoomba(serialObject)
% pause(0.5)

%%
%turn & find red cone
iRobotTurnToCone(serialObject, mycam, HSV_red,t_red);

%%
% % turn right 90
% iRobotTurn(serialObject, -88.4);
% 
% %%
% %  go with cliff sensor
% len = 4;
% iRobotStopAtCliff(serialObject,len);
% 
% SetFwdVelRadiusRoomba(serialObject, -0.1, 0); 
% pause(0.5);
% 
% % 
% %%
% % turn right 90
%  iRobotTurn(serialObject, -88.4);
%  
% %%
% % go with cliff & range sensor
% len = 2.8;
% iRobotFollowCliff(serialObject, len);
% 
% SetFwdVelRadiusRoomba(serialObject, -0.1, 0); 
% pause(1);
% 
% 
% 
% %%
% % turn right 90
% iRobotTurn(serialObject, -88.4);
% 
% s = CliffSignalStrengthRoomba(serialObject);
% if(s(1)<2500)
%     SetFwdVelAngVelRoomba(serialObject, 0, 10/180*pi); 
%     pause(.5);
% end
% 
% %%
% % decoder
% binaryvect = zeros(1,4);
% SetFwdVelRadiusRoomba(serialObject, 0.1, 0); 
% pause(.8);
% 
% for i = 1:4
%     SetFwdVelRadiusRoomba(serialObject, 0.1, 0);
%     pause(2.8);
%     
%     iRobotTurn(serialObject, -88.4);
% 
%     SetFwdVelRadiusRoomba(serialObject, 0, 0);
%     pause(0.1);
%     yellow = iRobotDetectCone(mycam, HSV_yellow, t_yellow);
%     purple = iRobotDetectCone(mycam, HSV_purple, t_purple);
%     
%     if purple>yellow
%         binaryvect(i) = 0;
%     else
%         binaryvect(i) = 1; 
%     end
%     
%     iRobotTurn(serialObject, 88.4);
%     pause(1);
% end

%binaryvect = [1 0 1 0];

%%
% everything above is tested , now should test beep function
% binarybeep
%binarybeep(serialObject, binaryvect);


% %%
% % go with cliff sensor
% len = round(36/0.3937);
% iRobotStopAtCliff(serialObject,len);
% 
% %%
% % turn right 90
% iRobotTurn(serialObject, -88.4);
% 
% %%
% % go with cliff & range sensor
% len = 2.8;
% iRobotFollowCliff(serialObject,len);

%%
% turn right 90
%iRobotTurn(serialObject, -88.4);
% 
% %%
% len = round(36/0.3937);
% iRobotStopAtCliff(serialObject,len);
% 
% %%
% % turn right 90
% iRobotTurn(serialObject, -88.4);
% 
% %%
% % go to cone
% iRobotGoToCone(serialObject, mycam, HSV_R);
% 
% %%
% % celebrate
% for i = 1:3
%     SetFwdVelAngVelRoomba(serialObject, 0, pi/2);
%     pause(4);
%     SetFwdVelAngVelRoomba(serialObject, 0, 0);
%     pause(1);
% end

%%
%end all

SetFwdVelRadiusRoomba(serialObject, 0, 0);

%PowerOffRoomba(serialObject)
