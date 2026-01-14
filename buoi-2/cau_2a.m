n = -10:14;
x = [-2, -1, 0, 1, 2];
xtilde = x' * ones(1, 5);
xtilde = xtilde(:)';

stem(n, xtilde, 'filled');
grid on;
xlabel('n');
ylabel('x(n)');
title('Bieu dien tin hieu x(n)');

