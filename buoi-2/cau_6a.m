% y(n) = x(n) - x(n-1)

% x(n) = 5[u(n) - u(n-20)]

[x1, n1] = ham_bac(0, -5, 25);    
[x2, n2] = ham_bac(20, -5, 25);
[y, n] = cong_2_tin_hieu(5*x1, n1, -5*x2, n2);

[x, n] = cong_2_tin_hieu(y, n, -1*dich_chuyen_tin_hieu(y, n, 1), n);

stem(n, x, 'filled');
grid on;
xlabel('n');
ylabel('x6a(n)');
title('Bieu dien tin hieu x6a(n)');