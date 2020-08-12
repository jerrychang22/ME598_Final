function binarybeep(serialObject, binaryvect)
% [serialObject] = RoombaInit(robotPort,'full')
% 
% % Read encoders (provides baseline)
% [StartLeftCounts, StartRightCounts] = EncoderSensorsRoomba(serialObject);


for i = 1:size(binaryvect,2) 
    if binaryvect(1,i) == 1
        fwrite(serialObject,[140 2 1 64 20]);
        fwrite(serialObject,[141 2]);
        pause(1);
    elseif binaryvect(1,i) == 0
        fwrite(serialObject,[140 2 1 57 20]);
        fwrite(serialObject,[141 2]);
        pause(1);
    else
        break;
    end
end
fwrite(serialObject, [140 2 1 60 20]);

end