robotPort = 9;
[serialObject] = RoombaInit(robotPort,'full')
%fwrite(serialObject,[140 2 1 64 20]);

% Read encoders (provides baseline)
[StartLeftCounts, StartRightCounts] = EncoderSensorsRoomba(serialObject);

pause(3);

binarybeep(serialObject, [1 0 1 0])

%pause(2);
%fwrite(serialObject,[140 5 1 57 20]);

%fwrite(serialObject,[141 2])

%fwrite(serialObject, [141 2])
pause(3);

PowerOffRoomba(serialObject)