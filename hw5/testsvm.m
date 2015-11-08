function accu = testsvm(test_data, test_label, w, b)
% Test linear SVM 
% Input:
%  test_data: M*D matrix, each row as a sample and each column as a
%  feature
%  test_label: M*1 vector, each row as a label
%  w: feature vector 
%  b: bias term
%
% Output:
%  accu: test accuracy (between [0, 1])
%
    num_correct = 0;
    for i = 1:size(test_data, 1)
        p = sign(test_data(i, :) * w + b);
        if (p == test_label(i))
            num_correct = num_correct + 1;
        end
    end
    accu = num_correct / size(test_data, 1);
end