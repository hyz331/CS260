function w = batch_gradient_descent(X, Y, alpha, lambda, num_iter, no_plot)

	if nargin < 5
		num_iter = 50;
        no_plot = 0;
    end
    
	num_iter
	num_train = size(X, 1);
	X = [X ones(num_train, 1)];
	num_feature = size(X, 2);

	% Initialize w
	w = zeros(1, num_feature);
	w(num_feature) = 0.1;

	points = [];

	for iter = 1:num_iter
		% Update w
		gradient = zeros(1, num_feature);
		for i = 1:num_train
			gradient = gradient + (sigmoid(w*X(i, :)') - Y(i)) .* X(i, 1:num_feature);
		end
		w = w - alpha .* gradient;
		w(1:(num_feature-1)) = w(1:(num_feature-1)) - 2 * lambda * w(1:(num_feature-1));

		% Compute cross-entropy
		cross_entropy = get_cross_entropy(X, Y, w, lambda);
		points = [points; [iter cross_entropy]];
    end


    if (no_plot == 1)
        return;
    end
    
	plot(points(:,1), points(:, 2));
	xlabel('iter');
	ylabel('cross-entropy');
	title(['step size: ', num2str(alpha)]);
end

