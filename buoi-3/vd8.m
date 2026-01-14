clc;
clear all;
close all;

n = 0:100;
x = cos(pi * n / 2);
k = -100:100;
w = (pi / 100) * k;

X = x * exp(-j * (pi / 100)).^(n' * k);

y = exp(j * pi * n / 4) .* x;
Y = y * exp(-j * (pi / 100)).^(n' * k);

subplot(2, 2, 1);
plot(w / pi, abs(X));
grid;
axis([-1, 1, 0, 60]);
title('Magnitude of X');
xlabel('frequency in pi units');
ylabel('|X|');

subplot(2, 2, 2);
plot(w / pi, angle(X) / pi);
grid;
axis([-1, 1, -1, 1]);
title('Angle of X');
xlabel('frequency in pi units');
ylabel('radians/pi');

subplot(2, 2, 3);
plot(w / pi, abs(Y));
grid;
axis([-1, 1, 0, 60]);
title('Magnitude of Y');
xlabel('frequency in pi units');
ylabel('|Y|');

subplot(2, 2, 4);
plot(w / pi, angle(Y) / pi);
grid;
axis([-1, 1, -1, 1]);
title('Angle of Y');
xlabel('frequency in pi units');
ylabel('radians/pi');

err = sum(abs(X(1:end - 25) - Y(26:end))) / length(X(1:end - 25));
disp(['Error between X and Y: ', num2str(err)]);
