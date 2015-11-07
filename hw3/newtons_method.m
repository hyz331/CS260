function [w] = newtons_method(X, Y, lambda, num_iter)
	if nargin < 4
		num_iter = 50;
    end

	w = batch_gradient_descent(X, Y, 0.01, 0.05, 6, 1);

	num_train = size(X, 1);
	X = [X ones(num_train, 1)];
	num_feature = size(X, 2);

	% Initialize w
	points = [];

	% Newton's method
	for iter = 1:num_iter
		iter

		% Find gradient
		gradient = zeros(1, num_feature);
		for i = 1:num_train
			gradient = gradient + (sigmoid(w*X(i, :)') - Y(i) ) .* X(i, 1:num_feature);
		end

		% Find Hessian
		H = zeros(num_feature, num_feature);
		for i = 1:num_train
			tmp = sigmoid(w*X(i, :)') * (1-sigmoid(w*X(i, :)'));
			H = H + X(i, :)' * X(i, :) * tmp;
		end

		% Add regularization term
		gradient(1:(num_feature-1)) = gradient(1:(num_feature-1)) + 2*lambda*w(1:(num_feature-1));
		for j = 1:(num_feature-1)
			H(j, j) = H(j, j) + 2*lambda;
		end

		% Update
		w = w - (pinv(H)*gradient')';
		points = [points; get_cross_entropy(X, Y, w, 0)];
    end

	plot(points);
	xlabel('iteration');
	ylabel('cross-entropy');
    title(num2str(lambda));
end
