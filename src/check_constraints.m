function isValid = check_constraints(x0, G, c, A_eq, b_eq, A_in, b_in)
    isValid = true;

    if (rank(A_eq) != rows(A_eq))
        isValid = false;
        disp('Error: The matrix A_eq is contains linearly dependent rows');
        return;
    endif

    if (isempty(G))
        isValid = false;
        disp('Error: G is empty');
        return;
    endif

    %verify if G is symmetric and square
    if (isequal(G, G') != 1)
        isValid = false;
        disp('Error: The matrix G is not symmetric or square');
        return;
    endif

    rH = rows(G);

    if (!isempty(x0) && rH != length(x0))
        isValid = false;
        disp('Error: The number of rows matrix G != length of x0');
        return;
    endif

    if (!isempty(c) && rH != length(c))
        isValid = false;
        disp('Error: The number of rows matrix G != length of c');
        return;
    endif

    if (!isempty(A_eq))
        [rA_eq, cA_eq] = size(A_eq);

        if (!isempty(b_eq) && rA_eq != length(b_eq))
            isValid = false;
            disp('Error: The number of rows in A_eq != length of b_eq');
            return;
        endif

        if (!isempty(x0) && cA_eq != length(x0))
            isValid = false;
            disp('Error: The number of columns in A_eq != length of x0');
            return;
        endif
    endif

    if (!isempty(A_in)) 
        [rA_in, cA_in] = size(A_in);

        if (!isempty(b_in) && rA_in != length(b_in))
            isValid = false;
            disp('Error: The number of rows in A_in != length of b_in');
            return;
        endif

        if (!isempty(x0) && cA_in != length(x0))
            isValid = false;
            disp('Error: The number of columns in A_in != length of x0');
            return;
        endif
    endif

endfunction
