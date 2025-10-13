% Load the image
img = imread("C:\Users\vasan\Downloads\download.jpeg");

% Check if the image is in color, convert it to grayscale if so
if size(img, 3) == 3
    img = rgb2gray(img); 
end

% Apply histogram equalization
equ = histeq(img);

% Stack original and equalized images side by side
res = [img, equ];

% Display the resultant image
imshow(res);
title('Original and Equalized Images');

% Plot the histogram and CDF for both images
figure;

subplot(2,1,1);
% Histogram of original image
imhist(img);
title('Histogram of Original Image');

subplot(2,1,2);
% Histogram of equalized image
imhist(equ);
title('Histogram of Equalized Image');

% CDF for original image
figure;
[counts, binLocations] = imhist(img);
cdf = cumsum(counts) / sum(counts);
plot(binLocations, cdf, 'b');
hold on;
% CDF for equalized image
[counts_eq, binLocations_eq] = imhist(equ);
cdf_eq = cumsum(counts_eq) / sum(counts_eq);
plot(binLocations_eq, cdf_eq, 'r');
title('CDF of Original and Equalized Images');
legend('Original CDF', 'Equalized CDF');
