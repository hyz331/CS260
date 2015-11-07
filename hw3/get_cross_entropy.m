function cross_entropy = get_cross_entropy(X, Y, w, lambda)
	num_train = size(X, 1);
	cross_entropy = 0;
	for i = 1:num_train
		if (Y(i) == 1)
			cross_entropy = cross_entropy + log(max(sigmoid(w*X(i,:)'), 1e-16));
		else
			cross_entropy = cross_entropy + log(max(1-sigmoid(w*X(i,:)'), 1e-16));
		end

		if (cross_entropy == -Inf)
			[Y(i), w*X(i,:)'] 
		end
	end	
	cross_entropy = -cross_entropy + lambda * norm(w(1:length(w)-1))^2;
end
