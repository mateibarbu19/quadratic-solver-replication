function result = demoQP(x0, G, c, A_eq, b_eq, A_in, b_in, varargin)
    display("========================= START =========================\n");

    if !check_constraints(x0, G, c, A_eq, b_eq, A_in, b_in)
        disp('The initial qp conditions regarding matrices and vectors are not respected');
        result = [];
        return
    endif

    L = rows(G);

    if (isempty(x0))
        A = [A_eq; A_in];
        A = [A -A];
        b = [b_eq; b_in];
        z = zeros(2 * L, 1);

        ctype = repmat("S", 1, rows(A_eq));
        ctype = [ctype repmat("L", 1, rows(A_in))];

        pm = glpk (z, A, b, [], [], ctype);
        x0 = pm(1:L) - pm(L + 1:end)
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

    if (nargin == 7)
        tol = 1e-12;
    endif

    disp('The matrices and vectors respects the initial  qp conditions');
    result = implementationQP(x0, G, c, A_eq, b_eq, A_in, b_in, tol);

endfunction
