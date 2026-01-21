clc;
clear all;
close all;

w_s1 = 0.3 * pi;
w_p1 = 0.4 * pi;
w_s2 = 0.6 * pi;
w_p2 = 0.5 * pi;
As = 44;
Rp = 0.5;
transition = min(w_p1 - w_s1, w_s2 - w_p2);

M = 45;
n = [0:1:(M - 1)];

if As > 50
    beta = 0.1102 * (As - 8.7);
elseif As >= 21
    beta = 0.5842 * (As - 21)^0.4 + 0.07886 * (As - 21);
else
    beta = 0;
end
w_kai = kaiser(M, beta)';

w_c1 = (w_s1 + w_p1) / 2;
w_c2 = (w_s2 + w_p2) / 2;

hd = ideal_lp(w_c2, M) - ideal_lp(w_c1, M);
h = hd .* w_kai;

[db, mag, pha, grd, w] = freqz_m(h, [1]);
delta_w = 2 * pi / 1000;

subplot(2, 2, 1);
stem(n, hd);
title('Ideal Impulse Response');
xlabel('n');
ylabel('hd(n)');
axis([0 M -0.4 0.5]);

subplot(2, 2, 2);
stem(n, w_kai);

title('Kaiser Window');
xlabel('n');
ylabel('w(n)');
axis([0 M 0 1.1]);

subplot(2, 2, 3);
stem(n, h);
title('Actual Impulse Response');
xlabel('n');
ylabel('h(n)');
axis([0 M -0.4 0.5]);

subplot(2, 2, 4);
plot(w / pi, db);
title('Magnitude Response in dB');
xlabel('frequency in pi units');
ylabel('Decibels');
axis([0 1 -80 10]);
grid;
