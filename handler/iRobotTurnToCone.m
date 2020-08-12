function iRobotTurnToCone(serialObject, mycam, HSV,t_red, pixel)
    dist = 160;
    while abs(dist) > 40
        SetFwdVelAngVelRoomba(serialObject, 0, -10/180*pi*sign(dist)); 
        pause(1);
        SetFwdVelRadiusRoomba(serialObject, 0, 0);
        pause(0.1);
        img = snapshot(mycam);
        %imshow(img);
        %imwrite(img,'trialImg.jpg');
        %[center,area] = BlobAnalysis('trialImg.jpg',HSV)
        [center,area] = BlobAnalysis(img,HSV, t_red, pixel);
        if size(area,1)~=0 && size(area,2)~=0
            [a,idx] = max(area);
                dist = min(center(idx,1) - 160);
        end
        
    end

    SetFwdVelRadiusRoomba(serialObject, 0, 0);
    pause(1);
    close;
end