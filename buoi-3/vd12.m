clc;
clear all;
close all;

N = 400;
Fs = [4 8 2.001];

for i = 1:length(Fs)
    t = (0:(N - 1)) / Fs(i);
    f = linspace(0, Fs(i), N);

    f0 = 1;
    f1 = 0.5;

    x0 = sin(2 * pi * f0 * t) + 0.55 * sin(2 * pi * f1 * t);
    y = fft(x0);

    figure;
    ax = axes('Position', [0.1, 0.2, 0.85, 0.65]);
    plot(f, abs(y), 'blue', 'LineWidth', 1, 'MarkerFaceColor', 'blue');
    title(['FFT with fs = ', num2str(Fs(i))]);
    xlabel('Frequency Index');
    ylabel('Magnitude');
end
