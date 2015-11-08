function [w,b] = trainsvm(train_data, train_label, C)
% Train linear SVM (primal form)
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  C: tradeoff parameter (on slack variable side)
%
% Output:
%  w: feature vector (column vector)
%  b: bias term
%
    [n, p] = size(train_data);
    for i = 1:n
       A(i, :) = train_data(i, :) * train_label(i); 
    end
    
    H = diag([ones(1, n), zeros(1, p+1)]);
    f = [zeros(1, p), C * ones(1, n), 0]';
    A = [A, eye(n), zeros(n, 1)];
    b = ones(n, 1);
    %lb = [-inf(p, 1); zeros(n, 1); -inf];
    res = quadprog(H, f, -A, -b, [], []);
    w = res(1:p, 1);
    p = res(length(res), 1);
end
