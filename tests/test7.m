x0 = [];

H = [
     1,  -1, 1;
    -1,  2, -2;
     1, -2,  4;
];

q = [
    -7;
    -12;
    -15
];

A = [
    1 1 1;
];

b = [
    3;
];

our = demoQP(x0, H, q, A, b, [], [])

correct = qp(x0, H, q, A, b)

assert(our, correct, 1e-12);
