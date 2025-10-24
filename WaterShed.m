clc;
clear;
close all;

% Step 1: Load the original color image
img = imread("C:\Users\vasan\Downloads\WhatsApp Image 2025-08-04 at 15.00.56_1ef3393e.jpg"); % Replace with your image
img = im2double(img); % Normalize to [0, 1] for blending

% Step 2: Compute a single-channel image for gradient (internally only)
% Use mean intensity across color channels to avoid converting to grayscale
intensity = mean(img, 3); % Still RGB input, but not shown as grayscale
gmag = imgradient(intensity); % Gradient magnitude for watershed

% Step 3: Manual Marker Input
figure, imshow(img), title('Draw markers (double-click to finish each region)');
hold on;
markerMask = zeros(size(intensity));

% Define fixed marker colors (first is red)
% Define fixed marker colors (more options, first is red)
markerColors = [
    1 0 0;       % 1 - Red
    0 1 0;       % 2 - Green
    0 0 1;       % 3 - Blue
    1 1 0;       % 4 - Yellow
    1 0 1;       % 5 - Magenta
    0 1 1;       % 6 - Cyan
    0.5 0 0;     % 7 - Dark Red
    0 0.5 0;     % 8 - Dark Green
    0 0 0.5;     % 9 - Dark Blue
    1 0.5 0;     % 10 - Orange
    0.5 0 0.5;   % 11 - Purple
    0.5 0.5 0;   % 12 - Olive
    0 0.5 0.5;   % 13 - Teal
    0.7 0.3 0.2; % 14 - Brown
    0.9 0.6 0.2; % 15 - Light Orange
];


numMarkers = input('Enter number of regions to segment: ');
for i = 1:numMarkers
    colorIdx = mod(i-1, size(markerColors,1)) + 1; % Loops if more markers than colors
    h = drawfreehand('Color', markerColors(colorIdx,:));
    mask = createMask(h);
    markerMask(mask) = i;
end

% Show the user-defined markers (for visual check)
figure, imshow(label2rgb(markerMask, 'jet', 'k')), title('User Markers');

% Step 4: Apply watershed using the drawn markers
L = watershed(imimposemin(gmag, markerMask));

% Step 5: Generate color segmentation map
segRGB = label2rgb(L, 'jet', 'k'); % Each region gets a color
segRGB = im2double(segRGB); % Normalize for blending

% Step 6: Create translucent overlay on the original image
alpha = 0.4; % Transparency level
overlay = (1 - alpha) * img + alpha * segRGB;

% Step 7: Overlay watershed boundaries (L == 0) in white
boundaries = L == 0;
overlay(repmat(boundaries, [1, 1, 3])) = 1; % Set boundary pixels to white

% Step 8: Show final result
figure, imshow(overlay), title('Watershed');