x0 = [];

H = [
     2,   1,  -1;
     1,   3, 1/2;
    -1, 1/2,   5;
];

q = [
     4;
    -7;
    12;
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


our = demoQP(x0, H, q, [], [], A_in, b_in)

correct = qp(x0, H, q, [], [], [], [], b_in, A_in, [])

assert(our, correct, 1e-12);
