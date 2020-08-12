function [yp_vector] = iRobotDetectBitCones(mycam,HSV_purple, HSV_yellow, t_purple, t_yellow)
    
    img = snapshot(mycam);

    [center_p,~, ~] = BlobAnalysis2(img,HSV_purple, t_purple, 200);
    [center_y,~, ~] = BlobAnalysis2(img,HSV_yellow, t_yellow, 200);
    
    yp_vector = zeros(1,2);
center_y
center_p
    if center_y(:,:) == 0
        center_y(center_y(:,:) == 0,:) = [];
    elseif center_p(:,:) == 0
        center_p(center_p(:,:) == 0,:) = [];
    end
    ry = size(center_y,1);
    rp = size(center_p,1);
    centroid_y = zeros(ry,1);
    centroid_p = zeros(rp,1);
    for i = 1:ry
        centroid_y(i) = center_y(i,1);
    end
    for i = 1:rp
        centroid_p(i) = center_p(i,1);
    end
    centroid_y
    centroid_p
    cones = [centroid_y(:,1); centroid_p(:,1)];
    sorted_cones = sort(cones, 'descend')
    
    for i = 1:2
        if ismember(sorted_cones(i),center_y)
            yp_vector(i) = 1; %yellow = 1
        else
            yp_vector(i) = 0;
        end

    end
   % yp_vector
    end