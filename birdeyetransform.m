function [B] = birdeyetransform(I)

% Describe camera configuration
    load('picam_params.mat');
    %focalLength    =  picam_params.FocalLength; % [fx, fy]
    %principalPoint =  picam_params.PrincipalPoint; % [cx, cy]
    %imageSize      = picam_params.ImageSize;           % [mrows, ncols]
    height         = 0.263;               % height in meters from the ground
    pitch          = 14;                   % pitch of the camera, towards the ground, in degrees
 
    %camIntrinsics = cameraIntrinsics(focalLength, principalPoint, imageSize);
    sensor = monoCamera(picam_params, height, 'Pitch', pitch);
    
 
    % Define bird's-eye-view transformation parameters
    distAheadOfSensor = 1; % in meters
    spaceToOneSide    = 0.50;  
    bottomOffset      = 0.35;  
    outView = [bottomOffset, distAheadOfSensor, -spaceToOneSide, spaceToOneSide];
    outImageSize = [NaN, 800]; % output image width in pixels
 
    birdsEyeConfig = birdsEyeView(sensor, outView, outImageSize);
 
    B = transformImage(birdsEyeConfig, I);
 
end

