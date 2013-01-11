function [ start_row, start_col, end_row, end_col ] = search_labels(grid, word)
    found = false;
    for r=1:15
       for c=1:15
			s = 1;
            % 1. Search horizontally, forwards and backwards  
            if(c+length(word)-1 <= 15)
                labels_word = grid(r,c:(c+length(word)-1));
                if(strcmpi(labels_word,word))
                    start_row = r;
                    start_col = c;
                    end_row = r;
                    end_col = c+length(word)-1;
                elseif(strcmpi(fliplr(labels_word),word))
                    start_row = r;
                    start_col = c+length(word)-1;
                    end_row = r;
                    end_col = c;
                end
            end
            
            % 2. Search vertically, forwards and backwards
            if(r+length(word)-1 <= 15)
                labels_word = char(grid(r:(r+length(word)-1),c));
                labels_word = reshape(labels_word,1,[]);
                            
                 if(strcmpi(labels_word,word))
                    start_row = r;
                    start_col = c;
                    end_row = r+length(word)-1;
                    end_col = c;
                 elseif(strcmpi(fliplr(labels_word),word))
                    start_row = r+length(word)-1;
                    start_col = c;
                    end_row = r;
                    end_col = c;
                 end              
            end
            
            % 3. Search Diagonally, forwards and backwards
            grid_word = '';
			grid_word2 = '';
            start_r = r;
            start_c = c;

			% iterate through each character in the search word
            for i=0:length(word)-1

				% 3.1 Search south-east and north-west (backwards and forwards)
				% if there is still enough space on the grid
                if(start_r+i <= 15 && start_c+i <= 15)
                    grid_word = strcat(grid_word, grid(start_r+i,start_c+i));		%concatenate the next word onto the string
                end

				% 3.2 Search north east and south-west (backwards and forwards)
                if(start_r-i >= 1 && start_c+i <= 15)
                    grid_word2 = strcat(grid_word2, grid(start_r-i,start_c+i));
                end
            end

			% south-east direction
            if(strcmpi(grid_word,word))
                start_row = start_r;
                start_col = start_c;
                end_row = start_row+length(word)-1;
                end_col = start_col+length(word)-1;

			% north-west direction
            elseif(strcmpi(fliplr(grid_word),word))
                start_row = start_r+length(word)-1;
                start_col = start_c+length(word)-1;
                end_row = start_r;
                end_col = start_c;

			% north east
            elseif(strcmpi(grid_word2,word))
                start_row = start_r;
                start_col = start_c;
                end_row = start_row-length(word)+1;
                end_col = start_col+length(word)-1;

			% south-west
            elseif(strcmpi(fliplr(grid_word2),word))
                start_row = start_r-length(word)+1;
                start_col = start_c+length(word)-1;
                end_row = start_r;
                end_col = start_c;
            end
       end
    end
end
