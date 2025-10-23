% Read grayscale images
img1 = imread("C:\Users\vasan\Downloads\WhatsApp Image 2025-08-04 at 15.00.54_71e7eed1.jpg");
img2 = imread("C:\Users\vasan\Downloads\WhatsApp Image 2025-08-04 at 15.00.54_b6557548.jpg");

% Convert to grayscale if images are RGB
if size(img1, 3) == 3
    img1 = rgb2gray(img1);
end
if size(img2, 3) == 3
    img2 = rgb2gray(img2);
end

% Detect ORB features
points1 = detectORBFeatures(img1);
points2 = detectORBFeatures(img2);

% Extract feature descriptors
[features1, validPoints1] = extractFeatures(img1, points1);
[features2, validPoints2] = extractFeatures(img2, points2);

% Match features using Hamming distance
indexPairs = matchFeatures(features1, features2, 'MatchThreshold', 50, 'MaxRatio', 0.8);

% Retrieve matched points
matchedPoints1 = validPoints1(indexPairs(:, 1));
matchedPoints2 = validPoints2(indexPairs(:, 2));

% Limit to available number of matches (max 50)
numMatchesToShow = min(50, size(indexPairs, 1));
matchedPoints1_disp = matchedPoints1(1:numMatchesToShow);
matchedPoints2_disp = matchedPoints2(1:numMatchesToShow);

% Visualize matches
figure;
showMatchedFeatures(img1, img2, matchedPoints1_disp, matchedPoints2_disp, 'montage');
title('ORB Feature Matches');

% Estimate homography using RANSAC if enough matches
if size(indexPairs, 1) > 10
    [tform, inlierIdx] = estimateGeometricTransform2D(...
        matchedPoints1, matchedPoints2, 'projective', 'MaxDistance', 5);
    
    % Homography matrix
    H = tform.T;
    disp('Estimated Homography Matrix:');
    disp(H);
end

