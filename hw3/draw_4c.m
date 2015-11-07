function draw_4c(X, Y, X_test, Y_test)
	num_train = size(X, 1);
	num_test = size(X_test, 1);

	counter = 0;
	figure
	for i = [0.001 0.01 0.05 0.1 0.5]
		counter = counter + 1;
		subplot(5, 1, counter)

		points = [];
		points_test = [];
		for lambda = 0:0.05:0.5
			w = batch_gradient_descent(X, Y, i, lambda, 50, 1);
			points = [points; [lambda get_cross_entropy([X ones(num_train, 1)], Y, w, 0)]];
			points_test = [points_test; [lambda get_cross_entropy([X_test ones(num_test, 1)], Y_test, w, 0)]];
		end
		plot(points(:, 1), points(:, 2));
		hold on;
		plot(points_test(:, 1), points_test(:, 2), '--');
		legend('train', 'test');
		hold off;
	end

end
