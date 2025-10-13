clc;
clear;

% Read image
img1 = imread("C:\Users\vasan\Downloads\download.jpeg");
original_img = img1;
gray = rgb2gray(img1);
img = gray;

% Define structuring element
se = strel('rectangle', [5 5]);

% 1. Erosion
erosion = imerode(img, se);

% 2. Dilation
dilation = imdilate(img, se);

% 3. Opening
opening = imopen(img, se);

% 4. Closing
closing = imclose(img, se);

% 5. Gradient (Dilate - Erode)
gradient = imsubtract(imdilate(img, se), imerode(img, se));

% 6. Top Hat
tophat = imtophat(img, se);

% 7. Black Hat
blackhat = imbothat(img, se);

% 8. Rectangular Structuring Element
se_rect = strel('rectangle', [5 5]);
rectangle = imdilate(img, se_rect);

% 9. Elliptical Structuring Element
se_ellipse = strel('disk', 2); % 'disk' approximates ellipse
ellipse = imdilate(img, se_ellipse);

% 10. Cross Structuring Element
se_cross = strel('line', 5, 90);
cross = imdilate(img, se_cross);

% Display all results in subplots
figure;

subplot(3,4,1), imshow(original_img), title('Original Image');
subplot(3,4,2), imshow(gray), title('Gray Scale Image');
subplot(3,4,3), imshow(erosion), title('Erosion Image');
subplot(3,4,4), imshow(dilation), title('Dilation Image');
subplot(3,4,5), imshow(opening), title('Open Operation');
subplot(3,4,6), imshow(closing), title('Close Operation');
subplot(3,4,7), imshow(gradient), title('Gradient Operation');
subplot(3,4,8), imshow(tophat), title('Top Hat Operation');
subplot(3,4,9), imshow(blackhat), title('Black Hat Operation');
subplot(3,4,10), imshow(rectangle), title('Rectangular Structuring');
subplot(3,4,11), imshow(ellipse), title('Elliptical Structuring');
subplot(3,4,12), imshow(cross), title('Cross Structuring');