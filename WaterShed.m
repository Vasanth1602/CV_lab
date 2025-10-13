% Read and prepare the image
img = imread("C:\Users\vasan\Downloads\WhatsApp Image 2025-08-04 at 15.00.56_1ef3393e.jpg");
imgDouble = im2double(img);
tintedImg = imgDouble;

% Define 3 light tint colors: red, green, blue
colors = [ 1.0, 0.6, 0.6;   % Light red
           0.6, 1.0, 0.6;   % Light green
           0.6, 0.6, 1.0 ]; % Light blue

alpha = 0.4;  % Transparency level

for i = 1:3
    % Show image and ask user to draw a region
    imshow(tintedImg);
    colorNames = {'Red', 'Green', 'Blue'};
    title(['Draw Region #' num2str(i) ' (Color: ' colorNames{i} ')']);

    

    
    h = drawfreehand('Color', colors(i,:));
    mask = createMask(h);

    % Create tint layer for this region
    tintColor = reshape(colors(i,:), 1, 1, 3);
    tintLayer = repmat(tintColor, size(img,1), size(img,2), 1);
    mask3D = repmat(mask, [1, 1, 3]);

    % Apply blended tint only inside the drawn region
    tintedImg(mask3D) = (1 - alpha) * tintedImg(mask3D) + alpha * tintLayer(mask3D);
end

% Show the final result
figure;
imshow(tintedImg);
title('Multiple watershed Regions');