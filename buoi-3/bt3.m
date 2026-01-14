clc;
clear all;
close all;

% tao tin hieu roi rac tu 2 tin hieu 2sinf0t va 5cosf1t lan luot co tan so f0=2, f1=4, fs=24
f0 = 2;
f1 = 4;
fs = 24;

% a. chieu dai du lieu N=32 mau. xuat dang song thoi gian va pho tuong ung
N = 32;

t = (0:N - 1) / fs;
f = linspace(0, fs, N);

x0 = 2 * sin(2 * pi * f0 * t) + 5 * cos(2 * pi * f1 * t);
y = fft(x0);

figure(1);
subplot(2, 1, 1);
plot(f, abs(y), 'blue', 'LineWidth', 1, 'MarkerFaceColor', 'blue');
title('FFT with N=32');
xlabel('Frequency Index');
ylabel('Magnitude');
subplot(2, 1, 2);
plot(t, x0, 'red', 'LineWidth', 1, 'MarkerFaceColor', 'red');
title('Time Domain Signal with N=32');

% b. Tinh pho DTFT cho chuoi roi rac cau a. bieu dien pho trong khoang 0 den pi
w = 0:0.01:pi;

X = zeros(size(w));
for k = 1:length(w)
    X(k) = sum(x0 .* exp(-1j * w(k) * t * fs));
end

figure(2);
subplot(2, 1, 1);
plot(w, abs(X));
title('Magnitude Part');
xlabel('frequency in pi units');
ylabel('Magnitude');
subplot(2, 1, 2);
plot(w, angle(X));
title('Phase Part');
xlabel('frequency in pi units');
ylabel('Phase');

% c. So sanh pho trong cau a va cau b. cho biet tan so omega cua song cos co gia tri bang bao nhieu rad va co gia tri bang bao nhieu trong pho FFT
figure(3);
hold on;
plot(f(1:N / 2 + 1), abs(y(1:N / 2 + 1)), 'b', 'LineWidth', 1.5);
plot(w * fs / (2 * pi), abs(X), 'r--', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('FFT', 'DTFT');
title('Comparison of FFT and DTFT Magnitude Spectrum');
hold off;

omega_cos = 2 * pi * f1 / fs;
freq_index_cos = omega_cos * N / (2 * pi);
disp(['Tan so omega cua song cos: ', num2str(omega_cos), ' rad']);
disp(['Gia tri trong pho FFT: ', num2str(freq_index_cos)]);
