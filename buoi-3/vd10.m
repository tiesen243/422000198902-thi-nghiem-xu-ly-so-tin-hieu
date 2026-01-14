clc;
clear all;
close all;

% a.
N = 100;
n = 0:1:19;
a = cos(2 * pi * n * 5 / N);

figure;
subplot(2, 1, 1);
stem(n, a);
title('Original Discrete Signal');
xlabel('Time Index');
ylabel('Amplitude');

b = fft(a);
subplot(2, 1, 2);
stem(n, abs(b));
xlim([min(n) max(n) + 1]);
title('Magnitude of FFT (Default Length)');
xlabel('Frequency Index');
ylabel('Magnitude');

% b.
c = fft(a, 200);
figure;
stem(abs(c));
title('Magnitude of FFT (Larger Length)');
xlabel('Frequency Index');
ylabel('Magnitude');

% c.
n = 0:1:99;
a = cos(2 * pi * n * 5 / N);

figure;
subplot(2, 1, 1);
stem(n, a, 'blue', 'LineWidth', 1, 'MarkerFaceColor', 'b');
title('Original Discrete Signal');
xlabel('Time Index');
ylabel('Amplitude');

b = fft(a);
subplot(2, 1, 2);
stem(n, abs(b), 'red', 'LineWidth', 1, 'MarkerFaceColor', 'r');
xlim([min(n) max(n) + 1]);
title('Magnitude of FFT (Default Length, N_F_F_T=20)');
xlabel('Frequency Index');
ylabel('Magnitude');
