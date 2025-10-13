filename = "C:\Users\vasan\Downloads\download.jpeg";
img = imread(filename);

img = imresize(img,[500,500]);
gray = rgb2gray(img);
blurred = imgaussfilt(gray,1);

edges_canny = edge(gray, 'canny');

edges_sobel = edge(blurred, 'sobel');

edges_prewitt = edge(blurred, 'prewitt');

laplacian_filter = fspecial('laplacian', 0.2);
edges_laplacian = imfilter(double(gray), laplacian_filter, 'replicate');
edges_laplacian = mat2gray(edges_laplacian);

edges_log = edge(gray, 'log');

gauss1 = imgaussfilt(double(gray), 1);
gauss2 = imgaussfilt(double(gray), 2);  
edges_dog = gauss1 - gauss2;
edges_dog = mat2gray(edges_dog);

titles = {'Original', 'Grayscale', 'Canny', 'Sobel', ...
          'Prewitt', 'Laplacian', 'LoG', 'DoG'};
images = {img, gray, edges_canny, edges_sobel, ...
          edges_prewitt, edges_laplacian, edges_log, edges_dog};

for i = 1:8
    subplot(2, 4, i);
    imshow(images{i});
    title(titles{i});
end
