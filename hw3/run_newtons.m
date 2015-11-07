function run_newtons(X_train, Y_train, X_test, Y_test)
	num_test = size(X_test, 1);
	X_test = [X_test ones(num_test, 1)];
	res = [];
    figure;
    k = 1;
    for i = 0:0.05:0.5
        subplot(3, 4, k);k = k+1;
		w = newtons_method(X_train, Y_train, i, 50);
		test_entropy = get_cross_entropy(X_test, Y_test, w, i);
		res = [res; [i norm(w) test_entropy]];
    end
end
