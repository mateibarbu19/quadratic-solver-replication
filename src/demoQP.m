function result = demoQP(x0, G, c, A_eq, b_eq, A_in, b_in)

    if !check_constraints(x0, G, c, A_eq, b_eq, A_in, b_in)
        disp('The initial qp conditions regarding matrices and vectors are not respected');
        result = [];
        return
    endif

    if (isempty(x0))
        A = [A_in; A_eq];
        b = [b_in; b_eq];
        lb = -Inf(rows(A), 1);
        c = zeros(columns(A), 1);

        ctype = [
            repmat("L", 1, rows(A_in)),
            repmat("S", 1, rows(A_in))
        ];

        x0 = glpk (c, A, b, lb, [], ctype)
    endif

    L = rows(G);

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
    result = implementationQP(x0, G, c, A_eq, b_eq, A_in, b_in);

endfunction
