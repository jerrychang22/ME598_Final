%stop when a cliff is detected by the Left sensor

function iRobotStopAtCliff2(serialObject, length)
    %s = CliffSignalStrengthRoomba(serialObject);
    %1 LftCliff 2 LftFrtnCliff 3 RgtFrntCliff 4 RgtCliff = CliffSignal(4);
    
    length = length *10;
    for i = 1:length
        SetFwdVelRadiusRoomba(serialObject, 0.1, 0)
        pause(0.1)
        s = CliffSignalStrengthRoomba(serialObject);
        if s(1) < 2500
            break;
        end
    end
    
    SetFwdVelRadiusRoomba(serialObject, 0, 0);
end