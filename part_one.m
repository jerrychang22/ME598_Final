clear all
%% Part 1
% Communicate to roomba
robotPort = 9;
[serialObject] = RoombaInit(robotPort,'full');
% Read encoders (provides baseline)
[StartLeftCounts, StartRightCounts] = ...
EncoderSensorsRoomba(serialObject)
BatteryChargeReaderRoomba(serialObject)

%red cone HSV value
HSV_red = [0.9927 0.8734 0.6894]; 

% Attach webcam
mycam = webcam; 
mycam.Resolution = '320x240';
figure(1)
img = snapshot(mycam);
imshow(img);
saveas(gcf,'final_one','jpg')
 
% Blob analysis
CD = colorDetectHSVimage('C:\Users\ME598\Desktop\ME598_Final_R5\final_one.jpg', HSV_red, [0.09,0.05,0.2]);
CDfiltered = bwareaopen(CD, 200);
CDfilled = imfill(CDfiltered, 'holes');
L = bwlabel(CDfilled);
s = regionprops(L);
areas = cat(1, s.Area);
Centroids = cat(1, s.Centroid);
% Get the centroid value for the region with the largest area
if isempty (Centroids)==1
	Centroids = [0 0];
end
CentroidX = Centroids(1,1);
% find the difference of the center of image from centroid of the cone
[nr, nc] = size(CD);
ImageCenterX = nc/2;
ImageCenterY = nr/2;
Xdiff = CentroidX - ImageCenterX;
 
% %if object is in front then stop the roomba	
% while abs(Xdiff)< 70       	
% 	SetFwdVelRadiusRoomba(serialObject, 0, 0);      	
% end 
 
%look for red cone
middlevalue=30;
rightend=180;
leftend=-180;
while abs(Xdiff)>middlevalue
	while Xdiff > leftend && Xdiff < middlevalue   	
	SetFwdVelRadiusRoomba(serialObject, 0.03, 0.001);  	
    pause(0.2);
	SetFwdVelRadiusRoomba(serialObject, 0, 0);  	
	img = snapshot(mycam); 	
	imshow(img); 	
	saveas(gcf,'part4b','jpg') 	
	CD = colorDetectHSVimage('C:\Users\ME598\Desktop\Lab 4 (Image processing)\part4b.jpg', HSV_red, [0.05,0.2,0.1]);
	CDfiltered = bwareaopen(CD, 200); 	
	CDfilled = imfill(CDfiltered, 'holes'); 	
	L = bwlabel(CDfilled); 	
	s = regionprops(L); 	
	areas = cat(1, s.Area); 	
	Centroids = cat(1, s.Centroid); 	
	CentroidX = Centroids(1,1); 	
	[nr, nc] = size(CD); 	
	ImageCenterX = nc/2; 	
	ImageCenterY = nr/2;
	Xdiff = CentroidX - ImageCenterX;  
	end
 
%if cone is in right part of picture
	while Xdiff > middlevalue && Xdiff < rightend  	
	SetFwdVelRadiusRoomba(serialObject, 0.03, -0.01);  	
	pause(0.2)   	
	SetFwdVelRadiusRoomba(serialObject, 0, 0);  	
	img = snapshot(mycam); 	
	imshow(img);
	saveas(gcf,'part4b','jpg') 	
	CD = colorDetectHSVimage('C:\Users\ME598\Desktop\Lab 4 (Image processing)\part4b.jpg', HSV_red, [0.05,0.2,0.1]);
	CDfiltered = bwareaopen(CD, 200); 	
	CDfilled = imfill(CDfiltered, 'holes'); 	
	L = bwlabel(CDfilled); 	
	s = regionprops(L);
	areas = cat(1, s.Area);     
	Centroids = cat(1, s.Centroid); 	
	CentroidX = Centroids(1,1); 	
	[nr, nc] = size(CD); 	
	ImageCenterX = nc/2; 	
	ImageCenterY = nr/2; 	
	Xdiff = CentroidX - ImageCenterX; 
	end
 
% if no cone in vision, make large turn
	while Xdiff < leftend || Xdiff > rightend  
	SetFwdVelRadiusRoomba(serialObject, 0.10, 0.01);	
	pause(2)   
	SetFwdVelRadiusRoomba(serialObject, 0, 0);	
	img = snapshot(mycam);	
	imshow(img);	
	saveas(gcf,'part4b','jpg')
	CD = colorDetectHSVimage('C:\Users\ME598\Desktop\Lab 4 (Image processing)\part4b.jpg', HSV_red, [0.05,0.2,0.1]);
	CDfiltered = bwareaopen(CD, 200); 	
	CDfilled = imfill(CDfiltered, 'holes'); 	
	L = bwlabel(CDfilled); 	
	s = regionprops(L); 	
	areas = cat(1, s.Area); 	
	Centroids = cat(1, s.Centroid); 	
	if isempty(Centroids) == 1    	
    	Centroids = [0,0];	
	end
	CentroidX = Centroids(1,1); 	
	[nr, nc] = size(CD); 	
	ImageCenterX = nc/2; 	
	ImageCenterY = nr/2; 	
	Xdiff = CentroidX - ImageCenterX;
		end
end

%if object is in front then stop the roomba	
while abs(Xdiff)< middlevalue       	
	SetFwdVelRadiusRoomba(serialObject, 0, 0);   
    break
end 


%% power off robot
 %stop the robot
SetFwdVelRadiusRoomba(serialObject, 0, 0);      	
PowerOffRoomba(serialObject)