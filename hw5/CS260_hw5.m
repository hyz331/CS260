% Load and process data
train = load('splice_train.mat');
test = load('splice_test.mat');
train.data = processData(train.data);
test.data = processData(test.data);

% Cross validation accuracy
%Cs = []; accu = [];
%for i = [-6 -5 -4 -3 -2 -1 0 1 2]
%    C = 4^i;
%    [w b] = trainsvm(train.data, train.label, C);
%    Cs = [Cs; C];
%    accu = [accu; testsvm(train.data, train.label, w, b)];
%end
%plot(Cs, accu);
%title('Cross validation accuracy');
%xlabel('C');
%ylabel('accuracy');
%[best_accu idx] = max(accu);
%best_c = Cs(idx)
%best_accu
%accu

% Test accuracy
%[w b] = trainsvm(train.data, train.label, best_c);
%test_accu = testsvm(test.data, test.label, w, b)

% Use libsvm

cd 'libsvm-3.20/matlab'
res = [];
for c = [-6 -5 -4 -3 -2 -1 0 1 2]
	accu = svmtrain(train.label, train.data, ['-v 5 ' '-c  ' num2str(4^c)]);
	res = [res; [c accu]];
end
res
return

cd 'libsvm-3.20/matlab'
res = [];
for d = [1 2 3]
	for c = [-3 -2 -1 0 1 2 3 4 5 6 7]
		accu = svmtrain(train.label, train.data, ['-t 1 -v 5 -d ' num2str(d) ' -c  ' num2str(4^c)]);
		res = [res; [d c accu]];
	end
end
res
