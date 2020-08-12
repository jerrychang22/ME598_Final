% testing finding red cone in the final step
%%
clear all

load HSV_red.mat
t_red = 0.005;


% Initialization
robotPort = 9;
[serialObject] = RoombaInit(robotPort,'full');
mycam = webcam;
mycam.Resolution='320x240';





img = snapshot(mycam);

[center,area] = BlobAnalysis(img,HSV_red, t_red, 50)
while isempty(area)
    SetFwdVelAngVelRoomba(serialObject, 0, 0.1);
    pause(1);
    SetFwdVelRadiusRoomba(serialObject, 0, 0);
    pause(0.1);
    img = snapshot(mycam);
    
    [center,area] = BlobAnalysis(img,HSV_red, t_red, 50)
end

if ~isempty(area) 
    img = snapshot(mycam);
    [center,area] = BlobAnalysis(img,HSV_red, t_red, 50)
    angle = (320-center(1))*15/160;
    if center(1) < 140
        disp('cone detected on the left, turning CCW');
        angle
        iRobotTurn(serialObject, angle);
        pause(1);
    elseif center(1) > 200
        disp('cone detected on the left, turning CCW');
        angle
        iRobotTurn(serialObject, -angle);
        pause(1);
    end
end




%%
%end all
SetFwdVelRadiusRoomba(serialObject, 0, 0);

%PowerOffRoomba(serialObject)
