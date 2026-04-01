% tao song gom 2 tan so 2kHz va 5kHz, hien thi dang song mien thoi gian va
% tan so

clc;
clear all;
close all;

Fs = 12e3;
t = 0:1/Fs:0.005;

f1 = 2e3;
f2 = 5e3;

y1 = sin(2*pi*f1*t);
y2 = sin(2*pi*f2*t);

y = y1 + y2;

figure;

subplot(2,2,1);
plot(t, y1);
legend('2kHz');
xlabel('t');
ylabel('y1');

subplot(2,2,2);
plot(t, y2);
legend('5kHz');
xlabel('t');
ylabel('y2');

subplot(2,2,3);
plot(t, y);
legend('Sum')
xlabel('t');
ylabel('y');

% 2. loc FIR loai bo 5kHz trong cau 1
N = 64;                    % bac loc FIR
fc = 3e3;                  % tan so cat de giu 2kHz, giam 5kHz
% Thiet ke FIR low-pass bang cong thuc windowed-sinc (khong can toolbox)
n = 0:N;
alpha = N / 2;
hd = (2*fc/Fs) * sinc((2*fc/Fs) * (n - alpha));
w = 0.54 - 0.46 * cos(2*pi*n/N); % cua so Hamming tu tinh
b = hd .* w;
b = b / sum(b);                   % chuan hoa gain tai DC = 1

y_fir = filter(b, 1, y);

Nfft = 4096;
f = (0:Nfft/2-1) * Fs / Nfft;
Y = fft(y, Nfft);
Y_fir = fft(y_fir, Nfft);

figure;
subplot(2,1,1);
plot(t, y, 'b', t, y_fir, 'r', 'LineWidth', 1);
legend('Tin hieu goc', 'Sau loc FIR');
xlabel('t (s)');
ylabel('Bien do');
title('Loc FIR loai bo thanh phan 5kHz');
grid on;

subplot(2,1,2);
plot(f, abs(Y(1:Nfft/2)), 'b', f, abs(Y_fir(1:Nfft/2)), 'r', 'LineWidth', 1);
legend('Pho truoc loc', 'Pho sau loc');
xlabel('f (Hz)');
ylabel('|Y(f)|');
xlim([0 Fs/2]);
grid on;