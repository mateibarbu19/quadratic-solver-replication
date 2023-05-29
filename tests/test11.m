x0 = [
    1;
    1;
];

H = [
    1 0;
    0 1;
];

our = demoQP(x0, H, [], [], [], [], [])

correct = qp(x0, H)

assert(our, correct, 1e-12);
