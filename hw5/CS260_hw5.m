% Load and process data
train = load('splice_train.mat');
test = load('splice_test.mat');
train.data = processData(train.data);
test.data = processData(test.data);

% Cross validation accuracy
Cs = []; accu = [];
for i = [-6 -5 -4 -3 -2 -1 0 1 2]
    C = 4^i;
    tic
    corr = cross_validation(train.data, train.label, C);
    toc
    Cs = [Cs; C];
    accu = [accu; corr];
end
[best_accu idx] = max(accu);
best_c = Cs(idx)
best_accu
accu

% Test accuracy
[w b] = trainsvm(train.data, train.label, best_c);
test_accu = testsvm(test.data, test.label, w, b)

% Use libsvm

cd 'libsvm-3.20/matlab'
res = [];
for c = [-6 -5 -4 -3 -2 -1 0 1 2]
	accu = svmtrain(train.label, train.data, ['-v 5 ' '-c  ' num2str(4^c)]);
	res = [res; [c accu]];
end
res

res = [];
for d = [1 2 3]
	for c = [-3 -2 -1 0 1 2 3 4 5 6 7]
		accu = svmtrain(train.label, train.data, ['-t 1 -v 5 -d ' num2str(d) ' -c  ' num2str(4^c)]);
		res = [res; [d c accu]];
	end
end
res

res = [];
for g = [-7 -6 -5 -4 -3 -2 -1 0 1 2]
	for c = [-3 -2 -1 0 1 2 3 4 5 6 7]
		accu = svmtrain(train.label, train.data, ['-t 2 -v 5 -g ' num2str(4^g) ' -c  ' num2str(4^c)]);
		res = [res; [g c accu]];
	end
end
res
