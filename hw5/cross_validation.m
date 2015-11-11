function accu = cross_validation(data, label, C)
    accu = 0;
    for i = 1:5
        indices = randperm(length(data));
        data_train = data(indices(1:800), :);
        label_train = label(indices(1:800));

        data_test = data(indices(801:1000), :);
        label_test = label(indices(801:1000));

        [w b] = trainsvm(data_train, label_train, C);
        accu = accu + testsvm(data_test, label_test, w, b);
    end
    accu = accu / 5;
end

