function [F_train C_train F_test C_test] = ionosphere_classification(filename)
	F = [];
	C = [];
    % Read features
	fid = fopen(filename);
	tline = fgets(fid);
	while ischar(tline)
		item = strsplit(tline, ',');
        row = [];
        for i = 1:34
            row = [row str2double(item{i})];
        end
		tline = fgets(fid);
        F = [F; row];
    end
	fclose(fid)
    
    % Read classes
    fid = fopen(filename);
	tline = fgets(fid);
    col = [];
	while ischar(tline)
		item = strsplit(tline, ',');
        if (item{35}(1) == 'g')
            col = [col; 1];
        else
            col = [col; 0];
        end
		tline = fgets(fid);
    end
    C = col;
	fclose(fid);
	F_train = F;
	C_train = C;
    
    % Run bath gradient descents, no regularization
	subplot(3, 2, 1);
	w1 = batch_gradient_descent(F, C, 0.001, 0);
	subplot(3, 2, 2);
	w2 = batch_gradient_descent(F, C, 0.01, 0);
	subplot(3, 2, 3);
	w3 = batch_gradient_descent(F, C, 0.05, 0);
	subplot(3, 2, 4);
	w4 = batch_gradient_descent(F, C, 0.1, 0);
	subplot(3, 2, 5);
	w5 = batch_gradient_descent(F, C, 0.5, 0);
	disp('No Regularization')
 	[[0.001, 0.01, 0.05, 0.1, 0.5]' [norm(w1), norm(w2), norm(w3), norm(w4), norm(w5)]'] 

  	% Run bath gradient descents, with lambda = 0.1
	figure;
	subplot(3, 2, 1);
	w1 = batch_gradient_descent(F, C, 0.001, 0.1);
	subplot(3, 2, 2);
	w2 = batch_gradient_descent(F, C, 0.01, 0.1);
	subplot(3, 2, 3);
	w3 = batch_gradient_descent(F, C, 0.05, 0.1);
	subplot(3, 2, 4);
	w4 = batch_gradient_descent(F, C, 0.1, 0.1);
	subplot(3, 2, 5);
	w5 = batch_gradient_descent(F, C, 0.5, 0.1);
	disp('Regularization')
 	[[0.001, 0.01, 0.05, 0.1, 0.5]' [norm(w1), norm(w2), norm(w3), norm(w4), norm(w5)]'] 

  	% Run Newton's method
	w1 = newtons_method(F, C, 0);

    % Read test features
	F = [];
	fid = fopen('ionosphere/ionosphere_test.dat');
	tline = fgets(fid);
	while ischar(tline)
		item = strsplit(tline, ',');
        row = [];
        for i = 1:34
            row = [row str2double(item{i})];
        end
		tline = fgets(fid);
        F = [F; row];
    end
	fclose(fid);
    
    % Read test classes
	C = [];
	fid = fopen('ionosphere/ionosphere_test.dat');
	tline = fgets(fid);
    col = [];
	while ischar(tline)
		item = strsplit(tline, ',');
        if (item{35}(1) == 'g')
            col = [col; 1];
        else
            col = [col; 0];
        end
		tline = fgets(fid);
    end
    C = col;
	fclose(fid);
	F_test = F;
	C_test = C;
    
    % Newtons
    run_newtons(F, C, F_test, C_test);
end
