function search_word(word)
	load assignment2.mat;
	img_vector = test1;
	imagesc(reshape(test1, 450, 450));
	pause(1.5);
	search_word(word,img_vector, train_data, train_labels);
end

function search_word(word,img_vector, train_data, train_labels)
alphabet = ['A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' ' '];


	% 1. Preprocessing
	pixel_features = [];    % each row is a sample of 900 pixel values

	% 1.1 Loop through each 30x30 square 
	for r=1:15
		for c=1:15
		    r_start = ((r*30)-29);
		    r_end = r*30;
		    c_start = ((c*30)-29);
		    c_end = c*30;

			% 1.2 Extract the 30x30 matrix of pixels which are sqaure slice of the image and it to bottom of pixel_features matrix
		    img_matrix = reshape(img_vector(r_start:r_end,c_start:c_end),1,[]);		
		    pixel_features = vertcat(pixel_features,img_matrix);	
		end
	end

	% 2. Classification
	% 2.1 Convert to a vector labels of 225 letters

	% find reduced training set
	labels = classify(train_data,train_labels,pixel_features);
	labels = alphabet(labels);

	% 2.2 Reshape this vector to a 15x15 matrix of letters
	labels = transpose(reshape(labels,15,15));

	% 3. Select a search word
	word = char(word)

	% 4. Perform the search
	[ start_row, start_col, end_row, end_col ] = search_labels(labels,word);

	% 5. Display the result
	% imagesc(reshape(img_vector,450,450));

	% 5.1 Convert the start/end rows/cols to pixel coordinates where each pixel is the center of that character square
	y1 = 14+30*(start_row-1)
	x1 = 14+30*(start_col-1)
	y2 = 14+30*(end_row-1)
	x2 = 14+30*(end_col-1)


	hold on
	% plot([1,450],[450,1]);
	plot([x1,x2],[y1,y2])
	colormap(gray);
end
