function [test_accu train_accu] = logistic_regression(tr, tl, vr, vl)
    % Use positive integers as labels
    vl = vl + 1;
    tl = tl + 1;
	B = mnrfit(tr, tl);
    
	% Run on test data
    num_correct = 0;
	for i = 1:length(vl)
        prob = mnrval(B, vr(i, :));
		[t pred] = max(prob);
		if (pred == vl(i))
			num_correct = num_correct + 1;
		end
	end
	test_accu = num_correct / length(vl);
    
    % Run on training data
    num_correct = 0;
	for i = 1:length(tl)
        prob = mnrval(B, tr(i, :));
		[t pred] = max(prob);
		if (pred == tl(i))
			num_correct = num_correct + 1;
		end
    end
    train_accu = (num_correct + 1) / length(tl);
end
