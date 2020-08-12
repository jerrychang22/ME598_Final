function iRobotTurn(serialObject, angle)
%left:+; right:-
   
angle = angle*pi/180; %convert angle
e = angle;

SetFwdVelAngVelRoomba(serialObject, 0, e);
pause(1);
SetFwdVelAngVelRoomba(serialObject, 0, 0);
pause(1);

end