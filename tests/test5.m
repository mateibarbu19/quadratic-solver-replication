x0 = [];

H = [
     1 -1;
    -1  2;
];

q = [
    -2;
    -6;
];


A_in = [
    -1 -1;
     1 -2;
    -2 -1;
];

b_in = [
    -2;
    -2;
    -3;
];


demoQP(x0, H, q, [], [], A_in, b_in)

qp(x0, H, q, [], [], [], [], b_in, A_in, [])

assert(our, correct, 1e-12);
