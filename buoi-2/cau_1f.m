n = -200:200;

% x = 2 * sin(0.01*pi*n) .* cos(0.5*pi*n);
[y, n] = nhan_2_tin_hieu(2*sin(0.01*pi*n), n, cos(0.5*pi*n), n);

stem(n, y, 'filled');
grid on;
xlabel('n');
ylabel('x6(n)');
title('Bieu dien tin hieu x6(n)');