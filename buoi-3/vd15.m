clc;
clear all;
close all;

Fs = 1000;
N = 50;
fc = 100;
n = 0:N - 1;

h = (2 * fc / Fs) * sinc(2 * fc * (n - (N - 1) / 2) / Fs);
a = [1, -1.5, 0.7];
b = h;

figure;
zplane(b, a);
title('Pole-Zero Plot of Filter H(z)');

figure;
[H_num, H_den] = residuez(b, a);

subplot(2, 1, 1);
zplane(H_num, H_den);
title('Pole-Zero Plot of Filter H(z) after transform partial-fraction expansion');

subplot(2, 1, 2);
stem(abs(H_num), 'filled');
title('Pole Magnitudes H(z)');

figure;
[H_fir, w_fir] = freqz(b, 1, 1024, Fs);
[H_combined, w_combined] = freqz(b, a, 1024, Fs);

subplot(2, 1, 1);
plot(w_fir, abs(H_fir));
hold on;
plot(w_combined, abs(H_combined), 'r');
title('Frequency Response Comparison');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('FIR Filter', 'Combined Filter H(z)');

subplot(2, 1, 2);
plot(w_fir, angle(H_fir));
hold on;
plot(w_combined, angle(H_combined), 'r');
title('Phase Response Comparison');
xlabel('Frequency (Hz)');
ylabel('Phase');
