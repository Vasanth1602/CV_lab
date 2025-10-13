% Read and display the image
img = imread("C:\Users\vasan\Downloads\WhatsApp Image 2025-08-04 at 15.00.56_1ef3393e.jpg");
figure, imshow(img), title('Original Image');

% Convert to grayscale
grayImg = rgb2gray(img);

% Compute the gradient magnitude using Sobel operator
gmag = imgradient(grayImg);
figure, imshow(gmag, []), title('Gradient Magnitude');

% Apply morphological operations to clean up the image
se = strel('disk', 3);
cleaned = imopen(grayImg, se);
cleaned = imclose(cleaned, se);

% Compute foreground markers using regional minima
foregroundMarkers = imextendedmin(cleaned, 20);
figure, imshow(foregroundMarkers), title('Foreground Markers');

% Modify the gradient image to force the watershed to align with object boundaries
gmag2 = imimposemin(gmag, foregroundMarkers);

% Apply watershed
L = watershed(gmag2);

% Create a label matrix with colored segments
Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
figure, imshow(Lrgb), title('Watershed Segmented Image');

% Optional: overlay the boundaries on the original image
boundaryMask = L == 0;
overlayed = img;
overlayed(repmat(boundaryMask, [1, 1, 3])) = 255;

figure, imshow(overlayed), title('Watershed Boundaries Overlaid on Original Image');
