function encoding = get_encoding(samples)
	categories = unique(samples);
	num_categories = length(categories);
	encoding = zeros(length(samples), num_categories);
	for i = 1:num_categories
		encoding(:,i) = (samples == categories(i));
	end
end
