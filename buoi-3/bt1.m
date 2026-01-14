clc;
clear all;
close all;

w = -pi:0.01:pi;

% a. x(n) = (0.6)^|n| * [u(n+10) - u(n-11)]
n = -10:10;
x = (0.6).^abs(n);

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

% b. x(n) = n(0.9)^n * [u(n) - u(n-21)]
n = 0:20;
x = n .* (0.9).^n;

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

% c. x(n) = [cos(0.5pi * n) +jsin(0.5pi * n)] * [u(n) - u(n-51)]
n = 0:50;
x = (cos(0.5 * pi * n) + 1j * sin(0.5 * pi * n));

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

% d. x(n) = {4, 3, 2*, 1, 1, 2, 3, 4}
n = 0:7;
x = [4, 3, 2, 1, 1, 2, 3, 4];

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
