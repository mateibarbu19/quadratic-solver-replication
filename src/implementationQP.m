function x = implementationQP(x0, G, c, A_eq, b_eq, A_in, b_in, tol)
    L = rows(G);
    M = rows(A_eq);
    N = rows(A_in);

    % TODO tolerance
    % the SUBset of the active constraints at x0
    idx_eq = find(A_eq * x0 == b_eq);
    idx_in = find(A_in * x0 >= b_in);
    x = x0;

    while 1
        display("\n============ loop ============\n");

        A = [A_eq(idx_eq, :); A_in(idx_in, :)];
        b = [b_eq(idx_eq, :); b_in(idx_in, :)];
        [~, K] = rref(A');

        A = A(K, :)
        b = b(K, :)
        m = rows(idx_eq) && !isempty(idx_eq);
        idx_eq = idx_eq(K <= m);
        idx_in = idx_in(K(K > m) - m);

        g = G * x + c;
        h = A * x - b;
        F = [G A'; A zeros(rows(A))];

        s = linsolve(F, [g; h]); % KKT

        p = -s(1:L)
        lambdas = s(L + 1:end)

        if (abs(p) < tol)
            display("\n========= p == 0 =========\n");

            m = rows(idx_eq) && !isempty(idx_eq);
            lambdas_in = lambdas(m + 1:end);

            if (isempty(idx_in) || all(lambdas_in >= -tol))
                return;
            else
                [~, j] = min(lambdas_in);
                idx_in(j) = [];
            endif

        else
            display("\n========= p != 0 =========\n");

            as_eq = alphas(M, A_eq, b_eq, x, p, idx_eq, tol)
            as_in = alphas(N, A_in, b_in, x, p, idx_in, tol)

            [a, j] = min([as_eq; as_in]);
            if (a >= 1 + tol)
                a = 1;
                j = Inf;
            endif

            x = x + a * p

            if (j <= M)
                idx_eq = [idx_eq; j];
            elseif (j <= M + N)
                idx_in = [idx_in; j - M];
            endif

        endif

    endwhile

endfunction
