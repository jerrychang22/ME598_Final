function iRobotTurnToCone2(serialObject, mycam, HSV,t_red, pixel)
img = snapshot(mycam);

[center,area] = BlobAnalysis(img,HSV, t_red, 50);
while isempty(area)
    SetFwdVelAngVelRoomba(serialObject, 0, 0.1);
    pause(1);
    SetFwdVelRadiusRoomba(serialObject, 0, 0);
    pause(0.1);
    img = snapshot(mycam);
    
    [center,area] = BlobAnalysis(img,HSV, t_red, 50);
end

if ~isempty(area)
    img = snapshot(mycam);
    [center,area] = BlobAnalysis(img,HSV, t_red, 50);
    angle = (320-center(1))*15/160;
    if center(1) < 140
%         disp('cone detected on the left, turning CCW');
        iRobotTurn(serialObject, angle);
        pause(1);
    elseif center(1) > 200
%         disp('cone detected on the left, turning CCW');
        iRobotTurn(serialObject, -angle);
        pause(1);
    end
end

SetFwdVelRadiusRoomba(serialObject, 0, 0);
pause(1);
close;
end