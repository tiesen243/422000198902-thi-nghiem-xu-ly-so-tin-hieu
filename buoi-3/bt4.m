clc;
clear all;
close all;

% tao tin hieu roi rac tu 2 tin hieu 4cosf0t va 2sinf1t lan luot co tan so f0=4, f1=8, fs=32
f0 = 4;
f1 = 8;
fs = 32;

% a. chieu dai du lieu N=62 mau. xuat dang song thoi gian va pho tuong ung
N = 62;

t = (0:N - 1) / fs;
f = linspace(0, fs, N);

x0 = 4 * cos(2 * pi * f0 * t) + 2 * sin(2 * pi * f1 * t);
y = fft(x0);

figure(1);
subplot(2, 1, 1);
plot(f, abs(y), 'blue', 'LineWidth', 1, 'MarkerFaceColor', 'blue');
title('FFT with N=62');
xlabel('Frequency Index');
ylabel('Magnitude');
subplot(2, 1, 2);
plot(t, x0, 'red', 'LineWidth', 1, 'MarkerFaceColor', 'red');
title('Time Domain Signal with N=62');

% b. chieu dai du lieu N=68 mau. xuat dang song thoi gian va pho tuong ung. Nhan xet ket qua
N = 68;

t = (0:N - 1) / fs;
f = linspace(0, fs, N);

x0 = 4 * cos(2 * pi * f0 * t) + 2 * sin(2 * pi * f1 * t);
y = fft(x0);

figure(2);
subplot(2, 1, 1);
plot(f, abs(y), 'blue', 'LineWidth', 1, 'MarkerFaceColor', 'blue');
title('FFT with N=68');
xlabel('Frequency Index');
ylabel('Magnitude');
subplot(2, 1, 2);
plot(t, x0, 'red', 'LineWidth', 1, 'MarkerFaceColor', 'red');
title('Time Domain Signal with N=68');

% Với N = 68 (không phải lũy thừa của 2), phổ FFT có thể xuất hiện hiện tượng rò rỉ phổ (spectral leakage) và các đỉnh không sắc nét như khi N = 62. Độ phân giải tần số thay đổi, các thành phần tần số chính có thể không trùng với các bin của FFT, làm cho các đỉnh bị trải rộng.

% c. Thay doi kich thuoc FFT lon hon FFT mac dinh o cau a. Nhan xet ket qua
N_fft = 128;

t = (0:N_fft - 1) / fs;
f = linspace(0, fs, N_fft);

x0 = 4 * cos(2 * pi * f0 * t) + 2 * sin(2 * pi * f1 * t);
y = fft(x0);

figure(3);
subplot(2, 1, 1);
plot(f, abs(y), 'blue', 'LineWidth', 1, 'MarkerFaceColor', 'blue');
title('FFT with N\_fft=128');
xlabel('Frequency Index');
ylabel('Magnitude');
subplot(2, 1, 2);
plot(t, x0, 'red', 'LineWidth', 1, 'MarkerFaceColor', 'red');
title('Time Domain Signal with N=62');

% Khi tăng kích thước FFT lên N_fft = 128 (lớn hơn chiều dài tín hiệu), độ phân giải tần số tăng lên, phổ trở nên mịn hơn và các đỉnh tần số rõ ràng hơn. Tuy nhiên, nếu tín hiệu được chèn thêm số 0 (zero-padding), sẽ không có thêm thông tin tần số mới, chỉ làm cho phổ trông liên tục hơn.

% d. Thay doi kich thuoc FFT nho hon FFT mac dinh o cau b. Nhan xet ket qua
N_fft = 31;

t = (0:N_fft - 1) / fs;
f = linspace(0, fs, N_fft);

x0 = 4 * cos(2 * pi * f0 * t) + 2 * sin(2 * pi * f1 * t);
y = fft(x0);

figure(4);
subplot(2, 1, 1);
plot(f, abs(y), 'blue', 'LineWidth', 1, 'MarkerFaceColor', 'blue');
title('FFT with N\_fft=31');
xlabel('Frequency Index');
ylabel('Magnitude');
subplot(2, 1, 2);
plot(t, x0, 'red', 'LineWidth', 1, 'MarkerFaceColor', 'red');
title('Time Domain Signal with N=68');

% Khi giảm kích thước FFT xuống N_fft = 31 (nhỏ hơn chiều dài tín hiệu), độ phân giải tần số giảm, phổ kém chi tiết hơn. Các đỉnh có thể bị rộng ra hoặc kém rõ ràng, một số thành phần tần số có thể bị bỏ sót hoặc gộp lại.
