n = -10:11;
x = 0.6.^abs(n);
k = -500:500;
w = (pi / 500) * k;
X = x * (exp(-1i * pi / 500)).^(n' * k);
magX = abs(X);
angX = angle(X);

subplot(2, 1, 1);
plot(w / pi, magX);

subplot(2, 1, 2);
plot(w / pi, angX);
