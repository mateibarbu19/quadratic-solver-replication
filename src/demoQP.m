function result = demoQP(x0, G, c, A_eq, b_eq, A_in, b_in)

    if !check_constraints(x0, H, q, A_eq, b_eq, A_in, b_in)
        disp('The initial qp conditions regarding matrices and vectors are not respected');
        result = [];
        return
    endif

    L = rows(G);

    if (isempty(x0))
        x0 = zeros (L, 1);
    endif

    if (isempty(A_eq) || isempty(b_eq))
        A_eq = zeros(1, L);
        b_eq = zeros(1);
    endif

    if (isempty(A_in) || isempty(b_in))
        A_in = zeros(1, L);
        b_in = zeros(1);
    endif

    if (isempty(c))
        c = zeros(L, 1);
    endif

    disp('The matrices and vectors respects the initial  qp conditions');
    result = implementationQP(x0, H, q, A_eq, b_eq, A_in, b_in);

endfunction
