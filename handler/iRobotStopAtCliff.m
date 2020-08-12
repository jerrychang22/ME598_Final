%stop when a cliff is detected by the Right sensor

function iRobotStopAtCliff(serialObject, length)
 
    %s = CliffSignalStrengthRoomba(serialObject);
    %1 LftCliff 2 LftFrtnCliff 3 RgtFrntCliff 4 RgtCliff = CliffSignal(4);
    
    length = length *10;
    for i = 1:length
        SetFwdVelRadiusRoomba(serialObject, 0.1, 0)
        pause(0.1)
        s = CliffSignalStrengthRoomba(serialObject);
        if s(4) < 2500
            break;
        end
    end
    
    SetFwdVelRadiusRoomba(serialObject, 0, 0);
end