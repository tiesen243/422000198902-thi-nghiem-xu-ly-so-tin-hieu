% x = {..., 1, 2, 3, ...} + {..., 1, 2, 3, 4, ...}, 0<=n<=24. so chu ki lap la bao nhieu

n = 0:24;
x1 = [1, 2, 3];
x2 = [1, 2, 3, 4];

xtilde1 = x1' * ones(1, 9);
xtilde1 = xtilde1(:)';
xtilde1 = xtilde1(1:25);
xtilde2 = x2' * ones(1, 7);
xtilde2 = xtilde2(:)';
xtilde2 = xtilde2(1:25);

[y, n] = cong_2_tin_hieu(xtilde1, n, xtilde2, n);

stem(n, y, 'filled');
grid on;
xlabel('n');
ylabel('x4(n)');
title('Bieu dien tin hieu x4(n)');

