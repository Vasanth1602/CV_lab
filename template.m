% Clear workspace and close all figures
clear; clc; close all;

% Load main image and template image paths
mainImagePath = "C:\Users\vasan\Downloads\FhjNHw2UUAE6PGb.jpg";
templateImagePath = "C:\Users\vasan\Downloads\images.jpeg";

% Try loading the images
try
    img = imread(mainImagePath);
    templateImg = imread(templateImagePath);
catch
    error('Error loading one or more images. Please check file paths.');
end

% Convert to grayscale if needed
if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

if size(templateImg, 3) == 3
    template_gray = rgb2gray(templateImg);
else
    template_gray = templateImg;
end

% Get template size
[templateH, templateW] = size(template_gray);

% Perform normalized cross-correlation
correlationMap = normxcorr2(template_gray, img_gray);

% Find peak correlation and its position
[maxCorr, maxIndex] = max(correlationMap(:));
[ypeak, xpeak] = ind2sub(size(correlationMap), maxIndex);

% Calculate the top-left corner of the matched region in the original image
yOffset = ypeak - templateH + 1;
xOffset = xpeak - templateW + 1;

% Clamp bounding box to image boundaries
xOffset = max(1, min(xOffset, size(img_gray, 2) - templateW));
yOffset = max(1, min(yOffset, size(img_gray, 1) - templateH));

% Display results
figure('Name', 'Template Matching Results', 'NumberTitle', 'off');

% Show normalized cross-correlation map
subplot(1, 3, 1); % Changed to 1, 3 to accommodate the template image
imagesc(correlationMap);
colormap('gray');
axis image;
colorbar;
title('Normalized Cross-Correlation Map');

% Show the template image
subplot(1, 3, 2); % Added subplot for the template image
imshow(templateImg);
title('Template Image');

% Show main image with detected template rectangle
subplot(1, 3, 3); % Changed to 1, 3 to accommodate the new layout
imshow(img);
hold on;
rectangle('Position', [xOffset, yOffset, templateW, templateH], ...
          'EdgeColor', 'r', 'LineWidth', 2);
title('Detected Template Region');
