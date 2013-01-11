function test_labels = classify(train, train_labels, test)
%CLASSIFY Simple implementation of a nearest neighbour classifier.
%  TEST_LABELS = CLASSIFY(TRAIN, TRAIN_LABELS, TEST) classifies the
%  samples stored in TEST and returns the corresponding estimated
%  TEST_LABELS. The matrix TEST hold the feature vectors that are
%  to be classified where each sample is stored as a separate
%  row. The matrix TRAIN is the training data feature vectors with
%  each sample being stored as a matrix row. TRAIN_LABELS is a
%  vector of integer class labels corresponding to the data in
%  TRAIN. 
%
%  The fucntion returns TEST_LABELS, a vector of integer class
%  labels corresponding to the data stored in the input TEST.
%
%  A -cosine distance metric is used for judging nearness, i.e. the
%  distance is taken to be the -cosine of the angle between pairs of
%  vectors.

% Compute -cosine of angles between all pairs of test-vector and train-vector
% using a.b = |a||b| cos(theta)

x= test * train';
modtest=sqrt(sum(test.*test,2));
modtrain=sqrt(sum(train.*train,2));
dist = -x./(modtest*modtrain'); 

% Find the index of the train vector with smallest distance to each
% test vector ...

[d,i]=min(dist');

% ... find the correspond label

test_labels = train_labels(i);


