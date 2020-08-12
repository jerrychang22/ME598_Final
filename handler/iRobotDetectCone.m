function bi = iRobotDetectCone(mycam,HSV, threshold, pixel)
    img = snapshot(mycam);
    [center,area] = BlobAnalysis(img,HSV, threshold, pixel);
    if size(area,1)~=0 && size(area,2)~=0
        bi = max(area);
    else
        bi = 0;
    end
    area
end