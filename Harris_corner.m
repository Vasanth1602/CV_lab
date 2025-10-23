% Read the input image
filename = "C:\Users\vasan\Downloads\ab0fc1334c6ed4f1a3860c21d199cd98.jpg";
img = imread(filename);
figure, imshow(img), title('Original Image');
% Convert to grayscale
gray = rgb2gray(img);
gray = double(gray);
% Detect corners using the Harris method
cornerStrength = cornermetric(gray, 'Harris');
% Dilate to mark corner areas (optional)
se = strel('disk', 1);
dilatedCorners = imdilate(cornerStrength, se);
% Thresholding
threshold = 0.01 * max(dilatedCorners(:));
cornerMask = dilatedCorners > threshold;
% Mark the corners in red
cornerImg = img;

red = cat(3, ones(size(gray)), zeros(size(gray)), zeros(size(gray))); % red color mask
cornerImg(repmat(cornerMask, [1, 1, 3])) = 0; % clear where corners are
cornerImg(:,:,1) = cornerImg(:,:,1) + uint8(255 * cornerMask); % add red
figure, imshow(cornerImg), title('Harris Corner Detection');