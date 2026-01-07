[x, n] = ham_xung(-2*-5, -10, 10);

for k = -5:5
    [xk, nk] = ham_xung(-2*k, -10, 10);
    [x, n] = cong_2_tin_hieu(x, n, exp(-abs(k))*xk, nk);
end

stem(n, x, 'filled');
grid on;
xlabel('n');
ylabel('x2(n)');
title('Bieu dien tin hieu x2(n)');