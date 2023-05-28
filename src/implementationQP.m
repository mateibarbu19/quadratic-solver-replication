function x = quadprog(x0, G, c, A_eq, b_eq, A_in, b_in)
    display("========================= START =========================\n");
    % TODO aproximate 0, aproximate 1?

    L = rows(G);
    M = rows(A_in);
    N = rows(A_eq);

    % the SUBset of the active constraints at x0
    idx_in = find(A_in * x0 >= b_in);
    idx_eq = find(A_eq * x0 == b_eq);
    x = x0;

    while 1
        display("\n============ loop ============\n");

        A = [A_in(idx_in, :); A_eq(idx_eq, :)];
        b = [b_in(idx_in, :); b_eq(idx_eq, :)];
        [~, K] = rref(A');

        A = A(K, :)
        b = b(K, :)
        m = rows(idx_in);
        idx_in = idx_in(K <= m);
        idx_eq = idx_eq(K(K > m) - m);

        g = G * x + c;
        h = A * x - b;
        F = [G A'; A zeros(rows(A))];

        s = linsolve(F, [g; h]); % KKT

        p = -s(1:L)
        lambdas = s(L + 1:end)

        if (abs(p) < 1e-12)
            display("\n========= p == 0 =========\n");

            ls_in = lambdas(1:rows(idx_in), :);

            if (isempty(idx_in) || all(ls_in >= 0))
                return;
            else
                [~, j] = min(ls_in);
                idx_in(j) = [];
            endif

        else
            display("\n========= p != 0 =========\n");

            as_in = alphas(M, A_in, b_in, x, p, idx_in)
            as_eq = alphas(N, A_eq, b_eq, x, p, idx_eq)

            [a, j] = min([as_in; as_eq; 1])

            x = x + a * p;

            if (j <= M)
                idx_in = [idx_in; j];
            elseif (j <= N + M)
                idx_eq = [idx_eq; j - M];
            endif

        endif

    endwhile

endfunction
