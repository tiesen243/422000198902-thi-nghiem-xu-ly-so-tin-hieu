n = 0:100;

% x = exp(0.01*n) .* sin(0.1*pi*n);
[y, n] = nhan_2_tin_hieu(exp(0.01 * n), n, sin(0.1 * pi * n), n);

stem(n, y, 'filled');
grid on;
xlabel('n');
ylabel('x9(n)');
title('Bieu dien tin hieu x9(n)');

