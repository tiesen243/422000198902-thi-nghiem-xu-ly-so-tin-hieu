clc;
clear all;
close all;

Fs = 1000;
N = 50;
fc = 100;
n = 0:N - 1;

h = (2 * fc / Fs) * sinc(2 * fc * (n - (N - 1) / 2) / Fs);
a = [1 0];
b = h;

figure;
subplot(2, 1, 1);
zplane(b, a);
title('Pole-Zero Plot of Filter');

subplot(2, 1, 2);
stem(abs(b), 'filled');
title('Pole Magnitudes');

[H, w] = freqz(b, a, 1024, Fs);

figure;
subplot(2, 1, 1);
plot(w, abs(H));
grid;
title('Frequency Response');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(2, 1, 2);
plot(w, angle(H));
grid;
title('Phase Response');
xlabel('Frequency (Hz)');
ylabel('Phase');
