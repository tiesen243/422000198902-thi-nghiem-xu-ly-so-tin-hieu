[x1, n1] = ham_bac(0, -2, 2);
[x2, n2] = ham_bac(20, -2, 2);
[y, n] = cong_2_tin_hieu(x1, n1, -x2, n2);
[y, n] = nhan_2_tin_hieu(exp(0.1 * n), n, y, n);

xtilde = y' * ones(1, 3);
xtilde = xtilde(:)';
ntilde = n(1) + (0:(length(xtilde) - 1));

stem(ntilde, xtilde, 'filled');
grid on;
xlabel('n');
ylabel('x2(n)');
title('Bieu dien tin hieu x2(n)');

