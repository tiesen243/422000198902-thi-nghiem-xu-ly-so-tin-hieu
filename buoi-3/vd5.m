clc;
clear all;
close all;

n = 0:10;
x = (0.9 * exp(j * pi / 3)).^n;
k = -200:200;
w = (pi / 100) * k;
X = x * exp(-j * (pi / 100)).^(n' * k);

magX = abs(X);
angX = angle(X);

subplot(2, 1, 1);
plot(w / pi, magX);
grid;
title('Magnitude Part');
xlabel('frequency in pi units');
ylabel('|X|');

subplot(2, 1, 2);
plot(w / pi, angX);
grid;
title('Angle Part');
xlabel('frequency in pi units');
ylabel('radians/pi');
