function trial2()
	load assignment2.mat

	% 1. Preprocessing
	pixel_features = [];    % each row is a sample of 900 pixel values

	imagesc(reshape(test1,450,450));
	% 1.1 Loop through each 30x30 square 
	for r=1:15
		for c=1:15
		    r_start = ((r*30)-29);
		    r_end = r*30;
		    c_start = ((c*30)-29);
		    c_end = c*30;
		    img_matrix = reshape(test1(r_start:r_end,c_start:c_end),1,[]);
		    pixel_features = vertcat(pixel_features,img_matrix);
		end
	end

	% Compute the pca coponents
	covx = cov(train_data);
	[V,d] = eigs(covx,11);

	% project the data onto the pca axes
	pca_train_data = (train_data - repmat(mean(train_data), 699, 1)) * V;
	pca_test_data = (pixel_features - repmat(mean(train_data),225,1)) * V;

	% select 10 features
	pca_test_reduced = pca_test_data(:,2:11);
	pca_train_reduced = pca_train_data(:,2:11);

	% perform the search
	for i=1:size(words)(1)
		search_word(words(i),test1, pca_train_reduced, train_labels, img_matrix, pca_test_reduced)
	end
end

function search_word(word,img_vector, train_data, train_labels,img_matrix,pixel_features)
	alphabet = ['A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' ' '];

	% 2. Classification
	% find reduced training set
	labels = classify(train_data,train_labels,pixel_features);
	labels = alphabet(labels);

	% 2.2 Reshape this vector to a 15x15 matrix of letters
	labels = transpose(reshape(labels,15,15));

	% 3. Select a search word
	word = char(word);

	% 4. Perform the search
	[ start_row, start_col, end_row, end_col ] = search_labels(labels,word);

	% 5. Display the result
	% imagesc(reshape(img_vector,450,450));

	% 5.1 Convert the start/end rows/cols to pixel coordinates where each pixel is the center of that character square
	y1 = 14+30*(start_row-1);
	x1 = 14+30*(start_col-1);
	y2 = 14+30*(end_row-1);
	x2 = 14+30*(end_col-1);

	hold on
	plot([x1,x2],[y1,y2])
	colormap(gray);
end
