clc;
clear all;
close all;

w_s1 = 0.2 * pi;
w_p1 = 0.35 * pi;
w_s2 = 0.8 * pi;
w_p2 = 0.65 * pi;
As = 60;

transition = min(w_p1 - w_s1, w_s2 - w_p2);
M_order = ceil(11 * pi / transition) + 1;
n_sequnce = [0:1:M_order - 1];

w_c1 = (w_s1 + w_p1) / 2;
w_c2 = (w_s2 + w_p2) / 2;

h_ideal = ideal_lp(w_c2, M_order) - ideal_lp(w_c1, M_order);
window_blackman = blackman(M_order)';

h_actual = h_ideal .* window_blackman;

[db, mag, pha, grd, w] = freqz_m(h_actual, [1]);
delta_w = 2 * pi / 1000;

ripple_pass = -(min(db(w_p1 / delta_w + 1:1:w_p2 / delta_w)));
attenuation_stop = -round(max(db(w_s2 / delta_w + 1:1:501)));

subplot(2, 2, 1);
stem(n_sequnce, h_ideal, 'b');
title('Ideal Impulse Response');
xlabel('n');
ylabel('hd(n)');
axis([0 M_order -0.4 0.5]);

subplot(2, 2, 2);
stem(n_sequnce, window_blackman, 'b');
title('Blackman Window');
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
