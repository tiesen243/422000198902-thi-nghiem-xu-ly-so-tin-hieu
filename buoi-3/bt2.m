clc;
clear all;
close all;

w = 0:0.01:pi;

% a. x(n) = 2*(0.5)^n * u(n+2)
n = -2:50;
x = 2 * (0.5).^n;

X = zeros(size(w));
for k = 1:length(w)
    X(k) = sum(x .* exp(-1j * w(k) * n));
end

figure(1);
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

% b. x(n) = (0.6)^|n| * [u(n+10) - u(n-11)]
n = -10:10;
x = (0.6).^abs(n);

X = zeros(size(w));
for k = 1:length(w)
    X(k) = sum(x .* exp(-1j * w(k) * n));
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

% c. x(n) = n(0.9)^n * u(n+3)
n = -3:50;
x = n .* (0.9).^n;

X = zeros(size(w));
for k = 1:length(w)
    X(k) = sum(x .* exp(-1j * w(k) * n));
end

figure(3);
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

% d. x(n) = (n+3)*(0.8)^(n-1) * u(n-2)
n = 2:50;
x = (n + 3) .* (0.8).^(n - 1);

X = zeros(size(w));
for k = 1:length(w)
    X(k) = sum(x .* exp(-1j * w(k) * n));
end

figure(4);
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

% e. x(n) = 4*(-0.7)^n * cos(0.25pi * n) * u(n)
n = 0:50;
x = 4 * (-0.7).^n .* cos(0.25 * pi * n);

X = zeros(size(w));
for k = 1:length(w)
    X(k) = sum(x .* exp(-1j * w(k) * n));
end

figure(5);
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
