clc;
clear all;
close all;

n = 0:200;
xn = 3 * sin(cos(32 * pi * n)) + 2 * cos(0.79 * pi);
hn = 0.6 * exp(-n);

% Q2.1.
figure(1);

subplot(2, 1, 1);
stem(n, xn);
xlabel('Time index');
ylabel('Apmplitude');
title('Signal x(n)');

X = fft(xn);

subplot(2, 1, 2);
stem(n, abs(X));
xlim([min(n) max(n) + 1]);
xlabel('Frequency index');
ylabel('Amplitude');
title('FFT of X');

Y = fft(hn);

subplot(2, 1, 2);
stem(n, abs(Y));
xlim([min(n) max(n) + 1]);
xlabel('Frequency index');
ylabel('Amplitude');
title('FFT of H');

% Q2.2.
figure(2);

M = 51;
wc = 1 / 2 * pi;

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
