clc;
clear all;
close all;

n = -10:10;
x = (-0.9).^n;
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

k = 0:200;
X_reversed = conj(X(201 - k));
X_conjugate = conj(X(k + 201));
err = norm(X_reversed - X_conjugate);
disp(['Norm of the error: ', num2str(err)]);
