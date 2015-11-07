function [code] = encode_email(dict, words)
	cellfind = @(string)(@(cell_contents)(strcmp(string,cell_contents)));

	code = zeros(1, length(dict));
	for i = 1:length(words)
		if (length(words{i}) > 0)
			code = code + cellfun(cellfind(words{i}), dict);
		end
	end
end
