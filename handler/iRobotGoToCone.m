function iRobotGoToCone(serialObject, mycam, HSV, threshold, pixel)
area = 0;
while max(area)<6500
    if max(area)>3500
        SetFwdVelRadiusRoomba(serialObject, 0.05, 0);
        pause(0.5);
        
%         angle = (320-center(1))*15/160;
%         
%         if center(1) < 140
%             iRobotTurn(serialObject, angle);
%         elseif center(1) > 200
%             iRobotTurn(serialObject, -angle);
%         end
    else
        SetFwdVelRadiusRoomba(serialObject, 0.1, 0);
        pause(0.5);
    end
    
    img = snapshot(mycam);
    %imwrite(img,'trialImg.jpg');
    %imshow(img);
    %[center,area] = BlobAnalysis('trialImg.jpg',HSV)
    [center,area] = BlobAnalysis(img,HSV,threshold, pixel);
    if(size(area,1)==0)
        area = 0;
    end
    %         max(area)
    
end
SetFwdVelRadiusRoomba(serialObject, 0, 0);
pause(1);
end