% 1. Load built-in digit dataset
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos','nndatasets','DigitDataset');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

% Count label distribution
disp(countEachLabel(imds))

% 2. Resize images and split into train/test sets
inputSize = [28 28];
imds.ReadFcn = @(filename)imresize(imread(filename), inputSize);

[imdsTrain, imdsTest] = splitEachLabel(imds, 0.7, 'randomized');

% 3. Define a simple CNN architecture
layers = [
    imageInputLayer([28 28 1])

    convolution2dLayer(3, 8, 'Padding','same')
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2, 'Stride', 2)

    convolution2dLayer(3, 16, 'Padding','same')
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2, 'Stride', 2)

    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer
];

% 4. Set training options
options = trainingOptions('adam', ...
    'MaxEpochs',5, ...
    'InitialLearnRate',1e-3, ...
    'ValidationData',imdsTest, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

% 5. Train the network
net = trainNetwork(imdsTrain, layers, options);

% 6. Predict on test data
YPred = classify(net, imdsTest);
YTest = imdsTest.Labels;

% 7. Evaluate accuracy
accuracy = sum(YPred == YTest)/numel(YTest);
fprintf('✅ CNN Test Accuracy: %.2f%%\n', accuracy * 100);

% 8. Confusion matrix
confusionchart(YTest, YPred);
title('CNN Confusion Matrix');

% 9. Show example predictions
idx = randperm(numel(imdsTest.Files), 9);
figure;
for i = 1:9
    subplot(3,3,i)
    img = readimage(imdsTest, idx(i));
    label = classify(net, img);
    imshow(img)
    title(sprintf('Predicted: %s', string(label)))
end

