function res = processData(data)
	m = mean(data);
	stdiv = std(data);
	for i = 1:size(data, 1)
		data(i, :) = (data(i, :) - m) ./ stdiv;
	end
	res = data;
end
