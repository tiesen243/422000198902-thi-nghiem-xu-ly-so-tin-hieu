n = 0:100;

% x = exp(-0.05*n) .* sin(0.1*pi*n + pi/3);
[y, n] = nhan_2_tin_hieu(exp(-0.05 * n), n, sin(0.1 * pi * n), n);

stem(n, y, 'filled');
grid on;
xlabel('n');
ylabel('x8(n)');
title('Bieu dien tin hieu x8(n)');

