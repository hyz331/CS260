function spam_classification(spams, hams, spams_test, hams_test)
	 F = [spams; hams];
	 C = [ones(size(spams, 1), 1); zeros(size(hams, 1), 1)];

	 % Run bath gradient descents, no regularization
	 subplot(3, 2, 1);
	 w1 = batch_gradient_descent(F, C, 0.001, 0);
	 subplot(3, 2, 2);
	 w2 = batch_gradient_descent(F, C, 0.01, 0);
	 subplot(3, 2, 3);
	 w3 = batch_gradient_descent(F, C, 0.05, 0);
	 subplot(3, 2, 4);
	 w4 = batch_gradient_descent(F, C, 0.1, 0);
	 subplot(3, 2, 5);
	 w5 = batch_gradient_descent(F, C, 0.5, 0);
	 disp('No Regularization')
	 [[0.001, 0.01, 0.05, 0.1, 0.5]' [norm(w1), norm(w2), norm(w3), norm(w4), norm(w5)]'] 

	 % Run bath gradient descents, with lambda = 0.1
	 figure;
	 subplot(3, 2, 1);
	 w1 = batch_gradient_descent(F, C, 0.001, 0.1);
	 subplot(3, 2, 2);
	 w2 = batch_gradient_descent(F, C, 0.01, 0.1);
	 subplot(3, 2, 3);
	 w3 = batch_gradient_descent(F, C, 0.05, 0.1);
	 subplot(3, 2, 4);
	 w4 = batch_gradient_descent(F, C, 0.1, 0.1);
	 subplot(3, 2, 5);
	 w5 = batch_gradient_descent(F, C, 0.5, 0.1);
	 disp('Regularization')
	 [[0.001, 0.01, 0.05, 0.1, 0.5]' [norm(w1), norm(w2), norm(w3), norm(w4), norm(w5)]'] 

	% Cross-entropy of test data
	disp('Cross-entropy test');
	F_test = [spams_test; hams_test];
	C_test = [ones(size(spams_test, 1), 1); zeros(size(hams_test, 1), 1)];
	num_test = size(F_test, 1);
	F_test = [F_test ones(num_test, 1)];

	% Run Newton's method with regularization
    figure;
    res = [];
    k = 1;
    for i = 0:0.05:0.5
        subplot(2, 6, k);k = k+1;
		w = newtons_method(F, C, i, 10);
		test_entropy = get_cross_entropy(F_test, C_test, w, i);
		res = [res; [i norm(w) test_entropy]];
    end
    res

end
