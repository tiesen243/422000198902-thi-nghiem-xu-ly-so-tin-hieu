% n = -5:15;

% x = zeros(size(n));

% x(n == -2) = 3;   % 3δ(n+2)
% x(n == 0)  = 2;   % 2δ(n)
% x(n == 3)  = -1;  % -δ(n-3)
% x(n == 7)  = 5;   % 5δ(n-7)

[x1, n1] = ham_xung(-2, -5, 15);
[x2, n2] = ham_xung(0, -5, 15);
[x3, n3] = ham_xung(3, -5, 15);
[x4, n4] = ham_xung(7, -5, 15);

[y, n] = cong_2_tin_hieu(3 * x1, n1, 2 * x2, n2);
[y, n] = cong_2_tin_hieu(y, n, -1 * x3, n3);
[x, n] = cong_2_tin_hieu(y, n, 5 * x4, n4);

stem(n, x, 'filled');
grid on;
xlabel('n');
ylabel('x1(n)');
title('Bieu dien tin hieu x1(n)');
