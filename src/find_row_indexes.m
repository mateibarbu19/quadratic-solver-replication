function indexes = find_row_indexes(O, A)
    indexes = [];  % Initialize output array
 
    for i = 1:rows(O)
        for j = 1:rows(A)
            if isequal(O(i, :), A(j, :))
                indexes = [indexes, j];
                break;
            end
        end
    end
end
