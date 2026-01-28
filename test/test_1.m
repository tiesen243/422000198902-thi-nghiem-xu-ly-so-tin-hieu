clc;
clear all;
close all;

n = 0:200;

% Q1.1.
figure(1);

xn = 5 * cos(22 * pi * n) + 4 * sin(0.89 * pi * n);
hn = 0.5 * exp(-n);

subplot(2, 1, 1);
stem(n, xn);
title('Signal x(n)');
xlabel('n');
ylabel('x(n)');

subplot(2, 1, 2);
stem(n, hn);
ylim([-0.1 0.6]);
title('Signal h(n)');
xlabel('n');
ylabel('h(n)');

% Q1.2.
figure(2);

[yn, no] = nhan_2_tin_hieu(xn, n, hn, n);

stem(no, yn);
title('Signal y(n) = x(n) * h(n)');
xlabel('n');
ylabel('y(n)');

% Q1.3.

k = -200:200;
w = (pi / 100) * k;

figure(3);
X = xn * exp(-j * pi / 100).^(n' * k);
magX = abs(X);
angX = angle(X);

subplot(2, 1, 1);
plot(w / pi, magX);
title('Magnitude Part of X');
xlabel('frequency in pi units');
ylabel('X');
grid;

subplot(2, 1, 2);
plot(w / pi, angX);
title('Angle Part of X');
xlabel('frequency in pi units');
ylabel('radians/pi');
grid;

figure(4);
Y = yn * exp(-j * pi / 100).^(n' * k);
magY = abs(Y);
angY = angle(Y);

subplot(2, 1, 1);
plot(w / pi, magY);
title('Magnitude Part of Y');
xlabel('frequency in pi units');
ylabel('Y');
grid;

subplot(2, 1, 2);
plot(w / pi, angY);
title('Angle Part of Y');
xlabel('frequency in pi units');
ylabel('radians/pi');
grid;

% Q1.4.
figure(5);

M = 51;
wc = pi / 2;

hd = ideal_lp(wc, M);
w_hamming = hamming(M)';

h1 = hd .* w_hamming;
[y1, no] = nhan_2_tin_hieu(xn, n, h1, 0:M - 1);
Y1 = fft(y1);

stem(n, abs(Y1));
xlim([min(n) max(n) + 1]);
title('FFT of Y1');
xlabel('Frequency index');
ylabel('Amplitude');
