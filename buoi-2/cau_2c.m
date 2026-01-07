[x1, n1] = ham_xung(0, -2, 2);
[x2, n2] = ham_xung(10, -2, 2);
[y, n] = cong_2_tin_hieu(x1, n1, -x2, n2);
[y, n] = nhan_2_tin_hieu(sin(0.1*pi*n), n, y, n);

xtilde = y' * ones(1, 4); xtilde = xtilde(:)';
ntilde = n(1) + (0:(length(xtilde)-1));

stem(ntilde, xtilde, 'filled');
grid on;
xlabel('n');
ylabel('x3(n)');
title('Bieu dien tin hieu x3(n)');