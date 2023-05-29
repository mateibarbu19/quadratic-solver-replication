x0 = [];

H = [
    1 -1;
    -1 2;
];

q = [
    -2;
    -6;
];

A = [
    1  1;
    1 -1;
];

b = [
    0;
    1;
];

our = demoQP(x0, H, q, A, b, [], [])

correct = qp(x0, H, q, A, b)

assert(our, correct, 1e-12);
