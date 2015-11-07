function [spams hams] = load_bag_of_words()
	% Load dictionary
	fid = fopen('spam/dic.dat');
	tline = fgets(fid);
	i = 1;
	while ischar(tline)
		tline = fgets(fid);
		dict{i} = tline(1:length(tline)-1);
		i = i+1;
	end
	fclose(fid);

	% Load spams
	spam_dir = 'spam/train/spam/';	
    spam_files = dir([spam_dir '*.txt']);
    num_spams = length(spam_files);
	spams = zeros(num_spams, length(dict));
    for i = 1:num_spams;
        spams(i, :) = encode_email(dict, textread([spam_dir spam_files(i).name], '%s'));
    end

	% Load hams 
	ham_dir = 'spam/train/ham/';	
    ham_files = dir([ham_dir '*.txt']);
    num_hams = length(ham_files);
	hams = zeros(num_hams, length(dict));
    for i = 1:num_hams;
        hams(i, :) = encode_email(dict, textread([ham_dir ham_files(i).name], '%s'));
    end

	% Normalize
	s = sum(spams) + sum(hams);
	s(s == 0) = 1;
	spams = spams ./ s;
	hams = hams ./ s;
end
