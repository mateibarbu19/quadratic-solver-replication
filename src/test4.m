x0 = [
    2;
    0;
];

H = [
    2 0;
    0 2;
];

q = [
    -2;
    -5;
];

A_eq = [
    1 0;
];

b_eq = [
    1.4;
];

A_in = [
    1 -2;
    -1 -2;
    -1 2;
    1 0;
    0 1;
];

b_in = [
    -2;
    -6;
    -2;
    0;
    0;
];

our = demoQP([], H, q, A_eq, b_eq, A_in, b_in)

correct = qp(x0, H, q, A_eq, b_eq, [], [], b_in, A_in, [])
