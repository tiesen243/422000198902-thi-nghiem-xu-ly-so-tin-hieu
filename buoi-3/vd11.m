clc;
clear all;
close all;

N  = 100;
N1 = 100 / 5;
T = [2 10 5.5];
Np = [2 * N1 10 * N1 5.5 * N1];

for i = 1:3
    figure(i);

    n = 0:1:Np(i) - 1;
    a = cos(2 * pi * n * 5 / N);

    subplot(2, 1, 1);
    stem(n, a, 'blue', 'LineWidth', 1, 'MarkerFaceColor', 'b');
    title(['Discrete Signal, Number of Cyclic = ', num2str(T(i))]);
    xlabel('Time Index');
    ylabel('Amplitude');

    b = fft(a);
    subplot(2, 1, 2);
    stem(n, abs(b), 'red', 'LineWidth', 1, 'MarkerFaceColor', 'r');
    xlim([min(n) max(n) + 1]);
    title(['Magnitude of FFT, Number of Cyclic = ', num2str(T(i))]);
    xlabel('Frequency Index');
    ylabel('Magnitude');
end
