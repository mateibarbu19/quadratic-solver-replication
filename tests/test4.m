x0 = [];

H = [
    2 0;
    0 2;
];

q = [
    -2;
    -5;
];

A_in = [
     1 -2;
    -1 -2;
    -1  2;
     1  0;
     0  1;
];

b_in = [
    -2;
    -6;
    -2;
     0;
     0;
];

our = demoQP(x0, H, q, [], [], A_in, b_in)

correct = qp(x0, H, q, [], [], [], [], b_in, A_in, [])

assert(our, correct, 1e-12);
