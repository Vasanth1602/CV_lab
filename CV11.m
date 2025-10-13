% Load Olivetti Faces dataset
% Replace 'olivetti_faces.mat' with your actual .mat file containing a variable 'X' of size (400 x 4096)
% Each row of X is a 64x64 image unrolled into a vector
load('olivetti_faces.mat');  % Ensure X is (400 x 4096)

numImages = 5;       % Number of images to show
imgSize = [64, 64];  % Image dimensions
nComponents = 100;   % Number of PCA components

% Center the data
X_mean = mean(X, 1);
X_centered = X - X_mean;

% PCA using SVD
[U, S, V] = svd(X_centered', 'econ');  % Transpose so features are in rows

% Project data onto top nComponents
V_reduced = V(:, 1:nComponents);
X_pca = X_centered * V_reduced;

% Reconstruct the images
X_reconstructed = X_pca * V_reduced' + X_mean;

% Visualize original and reconstructed images
for i = 1:numImages
    figure;

    % Original
    subplot(1, 2, 1);
    imshow(reshape(X(i, :), imgSize), []);
    title('Original');
    
    % Reconstructed
    subplot(1, 2, 2);
    imshow(reshape(X_reconstructed(i, :), imgSize), []);
    title(sprintf('Reconstructed (%d components)', nComponents));
end
