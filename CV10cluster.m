% Read the image
image = imread("C:\Users\vasan\Downloads\Gemini_Generated_Image_r2y2iar2y2iar2y2.png");
image = im2double(image);

% Reshape image into a 2D matrix (N x 3)
[m, n, c] = size(image);
image_reshaped = reshape(image, m*n, c);

% Apply K-means clustering
k = 3; % Number of clusters
[cluster_idx, cluster_centers] = kmeans(image_reshaped, k);

% Map the clustered result to the original image
clustered_image = reshape(cluster_idx, m, n);
imshow(clustered_image);
title('Clustered Image');
