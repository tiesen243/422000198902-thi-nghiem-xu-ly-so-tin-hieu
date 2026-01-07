% n = -25:15;

% u1 = double(n >= -20);  % u(n+20)
% u2 = double(n >= 10);   % u(n-10)

% x = exp(0.1*n) .* (u1 - u2);

[x1, n1] = ham_bac(-20, -25, 15);
[x2, n2] = ham_bac(10, -25, 15);
[y, n] = cong_2_tin_hieu(x1, n1, -1*x2, n2);
x = exp(0.1*n) .* y;

stem(n, x, 'filled');
grid on;
xlabel('n');
ylabel('x4(n)');
title('Bieu dien tin hieu x4(n)'); 