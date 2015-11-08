% Load and process data
train = load('splice_train.mat');
test = load('splice_test.mat');
train.data = processData(train.data);
test.data = processData(test.data);

% Cross validation accuracy
Cs = []; accu = [];
for i = [-6 -5 -4 -3 -2 -1 0 1 2]
    C = 4^i;
    [w b] = trainsvm(train.data, train.label, C);
    Cs = [Cs; C];
    accu = [accu; testsvm(train.data, train.label, w, b)];
end
plot(Cs, accu);
title('Cross validation accuracy');
xlabel('C');
ylabel('accuracy');
[best_accu idx] = max(accu);
best_c = Cs(idx)
best_accu
accu

% Test accuracy
[w b] = trainsvm(train.data, train.label, best_c);
test_accu = testsvm(test.data, test.label, w, b)