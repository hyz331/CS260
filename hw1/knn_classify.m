function [new_accu, train_accu] = knn_classify(train_data, train_label, new_data, new_label, k)
% k-nearest neighbor classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%  k: number of nearest neighbors
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data (using leave-one-out
%  strategy)
%
% CS260 2015 Fall, Homework 1

	num_train = length(train_data);
	num_new = length(new_data);
	num_test_correct = 0;
	num_train_correct = 0;

	% Test on test data
	for i = 1:num_new
		curr_features = new_data(i, :);
		curr_label = new_label(i, :);

		p = knn_classify_single(train_data, train_label, curr_features, k);

		if (p == curr_label)
			num_test_correct += 1;
		end
	end
	new_accu = num_test_correct / num_new;

	% Test on leave-one-out
	for i = 1:num_train
		curr_features = train_data(i, :);
		correct_label = train_label(i, :);
		curr_train = train_data;
		curr_train(i, :) = [];
		curr_train_label = train_label;
		curr_train_label(i, :) = [];

		p = knn_classify_single(curr_train, curr_train_label, curr_features, k);
		
		if (p == correct_label)
			num_train_correct += 1;
		end
	end
	train_accu = num_train_correct / num_train;
end
