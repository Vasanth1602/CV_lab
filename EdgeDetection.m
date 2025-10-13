% edge_detection_all.m
% Edge detection using Canny, Sobel, Prewitt, Laplacian, LoG, and DoG

% Step 1: Load image from local system
filename = "C:\Users\vasan\Downloads\download.jpeg";
img = imread(filename);

% Step 2: Resize for consistency (optional)
img = imresize(img, [500 500]);

% Step 3: Convert to grayscale
gray = rgb2gray(img);

% Step 4: Apply Gaussian Blur (used in some filters)
blurred = imgaussfilt(gray, 1);

% --- Canny ---
edges_canny = edge(gray, 'Canny');

% --- Sobel ---
edges_sobel = edge(blurred, 'Sobel');

% --- Prewitt ---
edges_prewitt = edge(blurred, 'Prewitt');

% --- Laplacian (approximate using fspecial and imfilter) ---
laplacian_filter = fspecial('laplacian', 0.2);
edges_laplacian = imfilter(double(gray), laplacian_filter, 'replicate');
edges_laplacian = mat2gray(edges_laplacian);  % Normalize for display

% --- LoG (Laplacian of Gaussian) ---
edges_log = edge(gray, 'log');

% --- DoG (Difference of Gaussian) ---
gauss1 = imgaussfilt(double(gray), 1);  % smaller sigma
gauss2 = imgaussfilt(double(gray), 2);  % larger sigma
edges_dog = gauss1 - gauss2;
edges_dog = mat2gray(edges_dog);  % Normalize for display

% --- Display all results ---
figure('Name', 'Edge Detection Techniques', 'NumberTitle', 'off');
subplot(2,4,1); imshow(img); title('Original');
subplot(2,4,2); imshow(gray); title('Grayscale');
subplot(2,4,3); imshow(edges_canny); title('Canny');
subplot(2,4,4); imshow(edges_sobel); title('Sobel');
subplot(2,4,5); imshow(edges_prewitt); title('Prewitt');
subplot(2,4,6); imshow(edges_laplacian); title('Laplacian');
subplot(2,4,7); imshow(edges_log); title('LoG');
subplot(2,4,8); imshow(edges_dog); title('DoG');
