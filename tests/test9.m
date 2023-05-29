x0 = [];

H = [
     1, -1,  1;
    -1,  2, -2;
     1, -2,  4;
];

q = [
     2;
    -3;
     1;
];

A_eq = [
    1 1 1;
];

b_eq = [
    1/2;
];

A_in = [
     1  0  0;
     0  1  0;
     0  0  1;
    -1  0  0;
     0 -1  0;
     0  0 -1;
];

b_in = [
     0;
     0;
     0;
    -1;
    -1;
    -1;
];

our = demoQP(x0, H, q, A_eq, b_eq, A_in, b_in)

correct = qp(x0, H, q, A_eq, b_eq, [], [], b_in, A_in, [])

assert(our, correct, 1e-12);
