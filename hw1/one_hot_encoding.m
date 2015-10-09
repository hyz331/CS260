% This function parses the input data and performs one hot encoding.
% It outputs the encoded feature and labels of input samples.
function [F, C] = one_hot_encoding(filename)

	function encoding = get_encoding(samples)
		categories = unique(samples);
		num_categories = length(categories);
		encoding = zeros(length(samples), num_categories);
		for i = 1:num_categories
			encoding(:,i) = (samples == categories(i));
		end
	end

	F = [];
	C = [];
	for i = 1:7
		fid = fopen(filename);
		tline = fgets(fid);
		col = [];
		while ischar(tline)
			item = strsplit(tline, ',');
			col = [col;item{i}(1)];
			tline = fgets(fid);
		end
		if (i <= 6)
			F = [F get_encoding(col)];
		else
			C = [C bin2dec(num2str(get_encoding(col)))];
		end
	end
end
