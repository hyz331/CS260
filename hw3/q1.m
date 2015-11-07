function [F, C] = q1(filename)
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
    
    % Run bath gradient descents, no regularization
	figure;
	batch_gradient_descent(F, C, 0.001);
	figure;
	batch_gradient_descent(F, C, 0.01);
	figure;
	batch_gradient_descent(F, C, 0.05);
	figure;
	batch_gradient_descent(F, C, 0.1);
	figure;
	batch_gradient_descent(F, C, 0.5);
end
