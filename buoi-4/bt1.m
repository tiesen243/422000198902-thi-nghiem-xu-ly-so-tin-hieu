clc;
clear all;
close all;

ws1 = 0.2 * pi;
wp1 = 0.35 * pi;
wp2 = 0.55 * pi;
ws2 = 0.75 * pi;
As = 40;
Rp = 0.25;

transition = min(wp1 - ws1, ws2 - wp2);
M_order = ceil(8 * pi / transition) + 1;
n_sequnce = [0:1:M_order - 1];

wc1 = (ws1 + wp1) / 2;
wc2 = (ws2 + wp2) / 2;

h_ideal = ideal_lp(wc2, M_order) - ideal_lp(wc1, M_order);
w_hann = hann(M_order)';

h_actual = h_ideal .* w_hann;

[db, mag, pha, grd, w] = freqz_m(h_actual, [1]);
delta_w = 2 * pi / 1000;

subplot(2, 2, 1);
stem(n_sequnce, h_ideal, 'b');
title('Ideal Impulse Response');
xlabel('n');
ylabel('hd(n)');
axis([0 M_order -0.4 0.5]);

subplot(2, 2, 2);
stem(n_sequnce, w_hann, 'b');
title('Hann Window');
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
