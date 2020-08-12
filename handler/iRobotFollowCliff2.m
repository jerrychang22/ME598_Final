% Using LeftFront and RightFront cliff sensors to follow the black line

function iRobotFollowCliff2(serialObject,len)
    s = CliffSignalStrengthRoomba(serialObject);
    len = len*10;
    cnt = 0; 
    while s(4) > 2500 && cnt<len
        %[Left, LeftFront, RightFront, Right]
        if s(1) > 2500  && s(2) > 2500 && s(3) > 2500  
            SetFwdVelRadiusRoomba(serialObject, 0.15, 0);
            pause(0.1);
            cnt = cnt+1;
        end
        
        if s(2) < 2500 
            SetFwdVelAngVelRoomba(serialObject, 0, 7/180*pi); %10
            pause(.5);
            SetFwdVelRadiusRoomba(serialObject, 0.1, 0);
            pause(0.2);
            %SetFwdVelAngVelRoomba(serialObject, 0, 10/180*pi);
            %pause(1);
        end
        
        if s(3) < 2500 
           SetFwdVelAngVelRoomba(serialObject, 0, -7/180*pi);
           pause(.7);
           SetFwdVelRadiusRoomba(serialObject, 0.1, 0);
           pause(0.2);
           %SetFwdVelAngVelRoomba(serialObject, 0, 10/180*pi); 
           %pause(1);
        end
        s = CliffSignalStrengthRoomba(serialObject);
    end
    
    SetFwdVelRadiusRoomba(serialObject, 0, 0);
    pause(0.1);
end
