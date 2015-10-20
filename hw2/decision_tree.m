function [test_accu train_accu] = decision_tree(tr, tl, vr, vl, testr, testl, SplitCriterion)
    
    for leaf = 1:10
        tree = ClassificationTree.fit(tr, tl, 'Prune', 'off', 'SplitCriterion', SplitCriterion, 'MinLeaf', leaf);
        % Run on valid data
        num_correct = 0;
        for i = 1:length(vl)
            pred = predict(tree, vr(i, :));
            if (pred == vl(i))
                num_correct = num_correct + 1;
            end
        end
        valid_accu = num_correct / length(vl);

        % Run on train data
        num_correct = 0;
        for i = 1:length(tl)
            pred = predict(tree, tr(i, :));
            if (pred == tl(i))
                num_correct = num_correct + 1;
            end
        end
        train_accu = num_correct / length(tl);
        
        % Run on test data
        num_correct = 0;
        for i = 1:length(testl)
            pred = predict(tree, testl(i, :));
            if (pred == testl(i))
                num_correct = num_correct + 1;
            end
        end
        train_accu = num_correct / length(testl);
    end
    
    [leaf train_accu valid_accu test_accu]
end
