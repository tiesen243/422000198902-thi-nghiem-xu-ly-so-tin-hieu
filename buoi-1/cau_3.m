clear;
close all;


% [n, x] = sin_signal(100, 2, 2);
% subplot(2, 1, 1);
% plot(n, x);
% xlabel("Thoi gian roi rac");
% title("DO THI TIN HIEU SIN");
% grid on;

% y = sign(x);
% subplot(2, 1, 2);
% plot(n, y);
% xlabel("Thoi gian roi rac");
% grid on;

[n, x] = sin_signal(100, 2, 2);

plot(n, x);
hold on;
y = sign(x);
plot(n, y, '--', 'LineWidth', 1.5);
hold off;

xlabel("Thoi gian roi rac");
title("DO THI TIN HIEU SIN VA SIGN");
legend("Sin", "Sign");
grid on;