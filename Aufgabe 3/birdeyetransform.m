function [B] = birdeyetransform(I)

% Describe camera configuration
[n,m]=size(I);
    load('picam_params.mat');
    imageSize      = picam_params.ImageSize;           % [mrows, ncols]
    focalLength    =  picam_params.FocalLength/imageSize(2)*m; % [fx, fy]
    principalPoint =  picam_params.PrincipalPoint/imageSize(2)*m; % [cx, cy]
    imageSize=[m,n];
    
    height         = 0.263;               % height in meters from the ground
    pitch          = 14;                   % pitch of the camera, towards the ground, in degrees
 
    camIntrinsics = cameraIntrinsics(focalLength, principalPoint, imageSize);
    sensor = monoCamera(camIntrinsics, height, 'Pitch', pitch);
    
 
    % Define bird's-eye-view transformation parameters
    distAheadOfSensor = 1; % in meters
    spaceToOneSide    = 0.40;  
    bottomOffset      = 0.4;  
    outView = [bottomOffset, distAheadOfSensor, -spaceToOneSide, spaceToOneSide];
    outImageSize = [NaN, 320]; % output image width in pixels
 
    birdsEyeConfig = birdsEyeView(sensor, outView, outImageSize);
 
    B = transformImage(birdsEyeConfig, I);
 
end

