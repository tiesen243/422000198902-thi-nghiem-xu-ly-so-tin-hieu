%  thiết kế bộ lọc thông dải sử dụng cửa sổ Hamming có thông số sau:
% lower stopband edge = 0.3π; As = 50 dB
% upper stopband edge = 0.7π; As = 50 dB
% upper passband edge = 0.6π; Rp = 0.2 dB
% lower passband edge = 0.35π; Rp = 0.2 dB

clc;
clear all;
close all;

ws1 = 0.3 * pi;
wp1 = 0.35 * pi;
wp2 = 0.6 * pi;
ws2 = 0.7 * pi;
As = 50;
Rp = 0.2;

transition = min(wp1 - ws1, ws2 - wp2);
M_order = ceil(6.6 * pi / transition) + 1;
n_sequnce = [0:1:M_order - 1];

wc1 = (ws1 + wp1) / 2;
wc2 = (ws2 + wp2) / 2;

h_ideal = ideal_lp(wc2, M_order) - ideal_lp(wc1, M_order);
w_ham = hamming(M_order)';
h_actual = h_ideal .* w_ham;

[db, mag, pha, grd, w] = freqz_m(h_actual, [1]);
delta_w = 2 * pi / 1000;

ripple_pass = -(min(db(wp1 / delta_w + 1:1:wp2 / delta_w)));
attenuation_stop = -round(max(db(ws2 / delta_w + 1:1:501)));

subplot(2, 2, 1);
stem(n_sequnce, h_ideal, 'b');
title('Ideal Impulse Response');
xlabel('n');
ylabel('hd(n)');
axis([0 M_order -0.4 0.5]);

subplot(2, 2, 2);
stem(n_sequnce, w_ham, 'b');
title('Hamming Window');
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
