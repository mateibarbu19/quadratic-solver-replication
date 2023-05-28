x0 = [];

H = [
    1;
];

q = [
    -7;
];

A = [
    3;
];

b = [
    6;
];

our = demoQP(x0, H, q, A, b, [], [])

correct = qp(x0, H, q, A, b)
