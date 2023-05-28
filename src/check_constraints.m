function isValid = check_constraints(x0, H, q, A_eq, b_eq, A_in, b_in)

    if (isempty(A_eq) || isempty(A_in))
        isValid = false;
        disp('Error: No contraints given');
        return;
    endif

    if (rank(A_eq) != rows(A_eq))
        isValid = false;
        disp('Error: The matrix A_eq is contains linearly dependent rows');
        return;
    endif

    %verify if H is symmetric and square
    if (isequal(H, H') != 1)
        isValid = false;
        disp('Error: The matrix H is not symmetric or square');
        return;
    endif

    [rH, cH] = size(H)

    if (!isempty(x0) && rH != length(x0))
        isValid = false;
        disp('Error: The number of rows matrix H != length of x0');
        return;
    endif

    if !isempty(q) && rH != length(q)
        isValid = false;
        disp('Error: The number of rows matrix H != length of q');
        return;
    endif

    [rA_eq, cA_eq] = size(A_eq)

    if !isempty(b_eq) && rA_eq != length(b_eq)
        isValid = false;
        disp('Error: rA_eq != length of b_eq');
        return;
    endif

    if !isempty(x0) && cA_eq != length(x0)
        isValid = false;
        disp('Error: cA_eq != length of x0');
        return;
    endif

    [rA_in, cA_in] = size(A_in)

    if !isempty(b_in) && rA_in != length(b_in)
        isValid = false;
        disp('Error: rA_in != length of b_in');
        return;
    endif

    if !isempty(x0) && cA_in != length(x0)
        isValid = false;
        disp('Error: cA_in != length of x0');
        return;
    endif

endfunction
