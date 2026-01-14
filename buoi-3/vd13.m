clc;
clear all;
close all;

b = [1, 0];
a = [1. -0.9];

[H, w] = freqz(b, a, 100);

magH = abs(H);
phaH = angle(H);

subplot(2, 1, 1);
plot(w / pi, magH);
grid;
title('Magnitude Response');
xlabel('frequency in pi units');
ylabel('Magnitude');

subplot(2, 1, 2);
plot(w / pi, phaH);
grid;
title('Phase Response');
xlabel('frequency in pi units');
ylabel('Phase in Radians');
