% Using Left cliff sensor to follow the black line

function iRobotFollowCliff(serialObject,len)
    s = CliffSignalStrengthRoomba(serialObject);
    len = len*10;
    cnt = 0;
    while  s(4) > 2500 && cnt<len
        SetFwdVelRadiusRoomba(serialObject, 0.1, 0);
        pause(0.1);
        cnt = cnt+1;
        % Added
        if s(1) < 2500 && s(2) < 2500
           SetFwdVelAngVelRoomba(serialObject, 0, -6/180*pi);
           pause(.5);
           SetFwdVelRadiusRoomba(serialObject, 0.1, 0);
           pause(0.05);
        end
        if s(1) > 2500 && s(2) < 2500
           SetFwdVelAngVelRoomba(serialObject, 0, -6/180*pi);
           pause(.2); %0.5
           SetFwdVelRadiusRoomba(serialObject, 0.1, 0);
           pause(0.2); %0.05
        end
        if s(1) > 2500 && s(2) > 2500
           SetFwdVelAngVelRoomba(serialObject, 0, 6/180*pi);
           pause(.7);
           SetFwdVelRadiusRoomba(serialObject, 0.1, 0);
           pause(0.2);           
        end
        %
%         r = max(RangeSignalStrengthRoomba(serialObject));
%         if r>300
%            SetFwdVelAngVelRoomba(serialObject, 0, 10/180*pi); 
%            pause(.5);
%            %SetFwdVelRadiusRoomba(serialObject, 0.1, 0);
%            %pause(0.05);
%            %SetFwdVelAngVelRoomba(serialObject, 0, -10/180*pi); 
%            %pause(1);
%        end
%         if s(2) < 2500 ||  s(3) < 2500
%            SetFwdVelAngVelRoomba(serialObject, 0, -6/180*pi); % changed from 10 to 6
%            pause(.5);
%            %SetFwdVelRadiusRoomba(serialObject, 0.1, 0);
%            %pause(0.05);
%            %SetFwdVelAngVelRoomba(serialObject, 0, 10/180*pi); 
%            %pause(1);
%         end
        s = CliffSignalStrengthRoomba(serialObject)
    end
    
    SetFwdVelRadiusRoomba(serialObject, 0, 0);
    pause(0.1);
end
