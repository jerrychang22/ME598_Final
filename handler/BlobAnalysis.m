function [centroid_needed,area_needed, number_to_trust] = BlobAnalysis(filename, HSV, threshold,pixel)
    CD = colorDetectHSVimage(filename, HSV, threshold);

    % Open image by removing connected pixel regions less than 200 pixels in
    % size
    CDfiltered = bwareaopen(CD, pixel);

    % Fill image
    CDfilled = imfill(CDfiltered, 'holes');

    % Label connected components
    L = bwlabel(CDfilled);

    % Calculate region properties for connected components
    s = regionprops(L);

    % Concatenate an array of all the region's 'area' values
    areas = cat(1, s.Area);
    [value, index1] = sort(areas);

    number_to_trust = sum(value>100);
    filter = zeros(size(areas));
    for i = 1:number_to_trust
        filter(index1(size(areas,1)+1-i)) = 1;
    end


    % Concatenate an array of all the region's 'centroid' values
    centroids = cat(1, s.Centroid);

    % Find the index in the 'areas' array corresponding to max_area
    idx = find(filter == 1);
    centroid_needed = filter.*centroids;
    
    %centroid_needed(centroid_needed(:,1) == 0,:) = [];

    % Get the centroid value for the region with the largest area
    %centroidX = centroid_needed(:,1);
    %centroidY = centroid_needed(:,2);

    % Select the connected component corresponding to this region
    BW2 = ismember(L, idx);

    % Plot the image of the largest connected region
    %figure(1)
    %imshow(BW2)
    %hold on

    % Plot a blue star in centroid of region
    %plot(centroidX, centroidY, 'b*')

    area_needed = areas.*filter;
    area_needed(area_needed < 1) = [];
    if sum(filter == 0)
        area_needed = [];
    end
    
    centroid_n = zeros(size(area_needed,2),2);
    cnt = 1;
    for i =1:size(centroid_needed,1)
        centroid_n(cnt,1) = centroid_needed(i,1);
        centroid_n(cnt,2) = centroid_needed(i,2);
        cnt = cnt+1;
    end

end
