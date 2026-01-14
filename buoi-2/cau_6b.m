% x(n) = n[u(n) - u(n-10)] + (20 - n)[u(n-10) - u(n-20)]

[x1, n1] = ham_bac(0, 0, 20);
[x2, n2] = ham_bac(10, 0, 20);
[y1, n6] = cong_2_tin_hieu(x1, n1, -1 * x2, n2);
[y1, n6] = n6 .* y1;  % n[u(n) - u(n-10)]

[x3, n3] = ham_bac(10, 0, 20);
[x4, n4] = ham_bac(20, 0, 20);
[y2, n7] = cong_2_tin_hieu(x3, n3, -1 * x4, n4);
[y2, n7] = (20 - n7) .* y2;  % (20 - n)[u(n-10) - u(n-20)]

[x, n] = cong_2_tin_hieu(y1, n6, y2, n7);
[x, n] = cong_2_tin_hieu(x, n, -1 * dich_chuyen_tin_hieu(x, n, 1), n);

stem(n, x, 'filled');
grid on;
xlabel('n');
ylabel('x6b(n)');
title('Bieu dien tin hieu x6b(n)');

