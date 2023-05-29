function as = alphas(D, A, b, x, p, idx, tol)
    display("\n====== alphas ======\n");

    not_idx = setdiff(1:D, idx);
    not_idx = setdiff(not_idx, find(A * p >= -tol));
    idx = setdiff(1:D, not_idx);

    A = A(not_idx, :);
    b = b(not_idx, :);

    as = zeros(D, 1);

    as(not_idx) = (b - A * x) ./ (A * p);
    as(idx) = inf;
endfunction
