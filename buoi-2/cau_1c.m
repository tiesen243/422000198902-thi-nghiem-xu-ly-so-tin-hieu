% n = -5:20;

% u = @(n) double(n >= 0);

% x = 10*u(n) - 5*u(n-5) - 10*u(n-10) + 5*u(n-15);

[x1, n1] = ham_bac(0, -5, 20);
[x2, n2] = ham_bac(5, -5, 20);
[x3, n3] = ham_bac(10, -5, 20);
[x4, n4] = ham_bac(15, -5, 20);

[y, n] = cong_2_tin_hieu(10 * x1, n1, -5 * x2, n2);
[y, n] = cong_2_tin_hieu(y, n, -10 * x3, n3);
[x, n] = cong_2_tin_hieu(y, n, 5 * x4, n4);

stem(n, x, 'filled');
grid on;
xlabel('n');
ylabel('x3(n)');
title('Bieu dien tin hieu x3(n)');
