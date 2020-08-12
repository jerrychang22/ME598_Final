function [binary] = getBinary(yellow, purple)
%binary = zeros(1,4);

yellowfiltered = bwareaopen(yellow, 200);
yellowfilled = imfill(yellowfiltered, 'holes');
yellowL = logical(yellowfilled);
yellows = regionprops(yellowL);
%yellowareas = cat(1, yellows.Area);
yellowcentroids = cat(1, yellows.Centroid);
figure(3)
imshow(yellowfilled)
title('Opened + Filled (Yellow)')


purplefiltered = bwareaopen(purple, 200);
purplefilled = imfill(purplefiltered, 'holes');
purpleL = logical(purplefilled);
purples = regionprops(purpleL);
%purpleareas = cat(1, purples.Area);
purplecentroids = cat(1, purples.Centroid);
figure(4)
imshow(purplefilled)
title('Opened + Filled (Purple)')


if size(yellowcentroids) == [0, 0]
    binary = [0 0 0 0]; %Must all be purple
elseif size(purplecentroids) == [0 0]
    binary = [1 1 1 1]; %Must all be yellow
else
    a = [yellowcentroids(:,2)' purplecentroids(:,2)'];
    y = ones(size(yellowcentroids(:,2)));
    p = zeros(size(purplecentroids(:,2)));
    c = [y' p'];
    total = [a; c];
    sort(a(1,:))
    [temp, order] = sort(total(1,:), 'descend');
    ret = total(:,order);
    binary = ret(2,:);
end





