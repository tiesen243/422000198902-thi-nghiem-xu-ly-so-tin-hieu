n = -200:200;

% x = 5 * (cos(0.49*pi*n) + cos(0.51*pi*n));

[y, n] = cong_2_tin_hieu(5*cos(0.49*pi*n), n, 5*cos(0.51*pi*n), n);

stem(n, y, 'filled');
grid on;
xlabel('n');
ylabel('x5(n)');
title('Bieu dien tin hieu x5(n)');