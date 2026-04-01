% loc FIR loai bo 5kHz trong cau 1

Fs = 12e6;
t = 0:1/Fs:0.005;

f1 = 2e3;
f2 = 5e3;

y1 = sin(2*pi*f1*t);
y2 = sin(2*pi*f2*t);

y = y1 + y2;

wp = 0.2*pi; ws = 0.3*pi; transition = ws - wp;
M = ceil(6.6 * pi / transition); n = [0:1:M-1]; wc = (ws+wp)/2;
hd = ideal_lp(wc, M); w_hamm = hamming(M)'; h = hd .* w_hamm;

[db, mag, pha, grd]
