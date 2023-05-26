function x = quadprog(x0, H, q, A_eq, b, A_in, lb)
    % TODO check linear independecy
    % TODO verify all dimensions
    % assert A is not full rank row
    L = rows(H);

    if (isempty(x0))
        x0 = zeros (L, 1)
    endif
    if (isempty(A_eq) || isempty(b))
        A_eq = zeros(1, L);
        b = zeros(1);
    endif
    if (isempty(A_in) || isempty(lb))
        A_in = zeros(1, L);
        lb = zeros(1);
    endif
    if (isempty(q))
        q = zeros(L, 1);
    endif

    M = rows(A_in);
    N = rows(A_eq);

    % the SUBset of the active constraints at x0
    idx_in = find(A_in * x0 >= lb)
    idx_eq = find(A_eq * x0 == b)
    x = x0;

    while 1
        display("\n============ loop ============\n");

        A = [A_in(idx_in, :); A_eq(idx_eq, :)];
        [~, K] = rref(A');

        A = A(K, :)
        % m = rows(idx_in)
        % idx_in = idx_in(K <= m)
        % idx_eq = idx_eq(K - m > 0)

        idx_in = find_row_indexes(A, A_in)
        idx_eq = find_row_indexes(A, A_eq)

        qk = H * x + q;
        z = zeros(rows(A), 1);

        p = qp([], H, qk, A, z)

        if (p == 0)
            display("\n========= p == 0 =========\n");

            lambdas = linsolve(A, H * x + q); % KKT

            ls_in = lambdas(1:rows(idx_in), :);

            if (isempty(idx_in) || all(ls_in >= 0))
                return;
            else
                [~, j] = min(ls_in);
                idx_in(j) = [];
            endif

        else
            display("\n========= p != 0 =========\n");

            as_in = alphas(M, A_in, lb, x, p, idx_in)
            as_eq = alphas(N, A_eq, b, x, p, idx_eq)

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
