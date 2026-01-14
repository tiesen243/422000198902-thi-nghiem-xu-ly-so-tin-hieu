% su dung conv de xác dinh tương quan
% x(n) = (0.9)^n, 0<= n <= 20
% y(n) = (0.8)^-n, -20 <= n <= 0
% su dung ham stem de bieu dien

n1 = 0:20;
x = (0.9).^n1;

n2 = -20:0;
y = (0.8).^(-n2);

z = conv(x, y);
n = (n1(1) + n2(1)):(n1(end) + n2(end));

stem(n, z, 'filled');
grid on;
xlabel('n');
ylabel('z(n)');
title('Bieu dien tin hieu z(n)');

