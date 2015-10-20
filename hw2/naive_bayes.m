function [new_accu, train_accu] = naive_bayes(train_data, train_label, new_data, new_label)
% naive bayes classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data 
%
% CS260 2015 Fall, Homework 2

	% Training
	num_train = size(train_data)(1);
	num_features = size(train_data)(2);
	num_class = 4;
	i = 1:num_train;
	prior = zeros(num_class, 1);

	% Compute prior
	for k = 1:num_class
		prior(k) = max(sum(train_label(i) == k-1) / num_train, 0.1);
	end

	% Comupte likelihood
	theta = zeros(num_features, num_class);
	tmp = [i' train_label];
	for i = 1:num_train
		theta(:, train_label(i)+1) += train_data(i, :)';
	end

	i = 1:num_train;
	for j = 1:num_class
		theta(:, j) = theta(:, j) ./ (sum(train_label(i) == j-1)+1); % Add one to avoid division by zero
	end


	% Fix zero likelihood with 0.01
	for i = 1:num_features
		for j = 1:num_class
			if (theta(i, j) == 0)
				theta(i, j) = 0.01;
			end
		end
	end

	% Run on test data
	num_correct = 0;
	num_test = size(new_data)(1);
	for i = 1:num_test
		posterior = ones(num_class, 1);
		for j = 1:num_class
			for k = 1:num_features
				if (new_data(i, k) == 1)
					posterior(j) *= theta(k, j);
				else
					posterior(j) *= (1-theta(k, j));
				end
			end
			posterior(j) *= prior(j);
		end
		[t c] = max(posterior);
		pred = c-1;
		if (pred == new_label(i))
			num_correct += 1;
		end
	end
	new_accu = num_correct / num_test;

	% Run on train data
	num_correct = 0;
	for i = 1:num_train
		posterior = ones(num_class, 1);
		for j = 1:num_class
			for k = 1:num_features
				if (train_data(i, k) == 1)
					posterior(j) *= theta(k, j);
				else
					posterior(j) *= (1-theta(k, j));
				end
			end
			posterior(j) *= prior(j);
		end
		[t c] = max(posterior);
		pred = c-1;
		if (pred == train_label(i))
			num_correct += 1;
		end
	end
	train_accu = num_correct / num_train;
end
