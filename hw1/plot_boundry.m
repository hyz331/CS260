function [] = plot_boundry(features, labels, k)
	X = 0:1/99:1;
	F1 = zeros(10000, 1);
	F2 = zeros(10000, 1);
	i = 1:10000;
	F1(i, :) = X(floor((i-1) / 100) + 1);
	F2(i, :) = X(mod((i-1), 100) + 1);
	M = [F1, F2];

	C = zeros(10000, 1);
	X_1 = []; X_2 = [];
	Y_1 = []; Y_2 = [];
	for i = 1:10000
		p = knn_classify_single(features, labels, M(i, :), k);
		if (p == 1)
			X_1 = [X_1; M(i, 1)];
			Y_1 = [Y_1; M(i, 2)];
		else
			X_2 = [X_2; M(i, 1)];
			Y_2 = [Y_2; M(i, 2)];
		end
	end

	scatter(X_1, Y_1, 'black');
	hold on;
	scatter(X_2, Y_2, 'w');
end
