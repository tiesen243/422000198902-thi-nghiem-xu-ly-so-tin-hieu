clc;
clear all;
close all;

ws = 0.4 * pi;
wp = 0.5 * pi;
As = 50;
Rp = 0.0004;

transition = wp - ws;
M_order = ceil((As - 7.95) / (2.285 * transition) + 1) + 1;
n_sequnce = [0:1:M_order - 1];

wc = (ws + wp) / 2;
h_ideal = ideal_lp(wc, M_order);
beta = 0.1102 * (As - 8.7);
w_kai = kaiser(M_order, beta)';
h_actual = h_ideal .* w_kai;

[db, mag, pha, grd, w] = freqz_m(h_actual, [1]);
delta_w = 2 * pi / 1000;

subplot(2, 2, 1);
stem(n_sequnce, h_ideal, 'b');
title('Ideal Impulse Response');
xlabel('n');
ylabel('hd(n)');
axis([0 M_order -0.4 0.5]);

subplot(2, 2, 2);
stem(n_sequnce, w_kai, 'b');
title('Kaiser Window');
xlabel('n');
ylabel('w(n)');
axis([0 M_order 0 1.1]);

subplot(2, 2, 3);
stem(n_sequnce, h_actual, 'b');
title('Actual Impulse Response');
xlabel('n');
ylabel('h(n)');
axis([0 M_order -0.4 0.5]);

subplot(2, 2, 4);
plot(w / pi, db, 'b');
title('Magnitude Response in dB');
xlabel('frequency in pi units');
ylabel('Decibels');
axis([0 1 -100 10]);
grid;
