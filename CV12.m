% Load Iris dataset
load fisheriris
X = meas;
y = species;

% Convert class labels to numeric for confusion matrix (optional)
classNames = unique(y);
y_numeric = grp2idx(y);

% Split data into training and testing sets (80/20 split)
cv = cvpartition(y, 'HoldOut', 0.2);
X_train = X(training(cv), :);
y_train = y(training(cv));
X_test = X(test(cv), :);
y_test = y(test(cv));

% Train k-NN classifier with k=3
knnModel = fitcknn(X_train, y_train, 'NumNeighbors', 3);

% Predict on test data
y_pred = predict(knnModel, X_test);

% Classification Report (manually computed)
confMat = confusionmat(y_test, y_pred);
disp('Confusion Matrix:')
disp(confMat)

% Display confusion matrix as chart
figure;
confusionchart(y_test, y_pred, 'Title', 'Confusion Matrix - Iris Dataset', ...
               'RowSummary','row-normalized', 'ColumnSummary','column-normalized');

% Calculate and display precision, recall, F1-score manually
fprintf('\nClassification Report:\n');
for i = 1:length(classNames)
    tp = confMat(i, i);
    fn = sum(confMat(i, :)) - tp;
    fp = sum(confMat(:, i)) - tp;
    tn = sum(confMat(:)) - tp - fp - fn;

    precision = tp / (tp + fp);
    recall = tp / (tp + fn);
    f1 = 2 * (precision * recall) / (precision + recall);

    fprintf('%s:\n', classNames{i});
    fprintf('  Precision: %.2f\n', precision);
    fprintf('  Recall:    %.2f\n', recall);
    fprintf('  F1-score:  %.2f\n\n', f1);
end
