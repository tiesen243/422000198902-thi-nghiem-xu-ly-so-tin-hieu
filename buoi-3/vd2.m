clc;
clear all;
close all;

w = -pi:0.01:pi;
X = exp(j * w) + 2 + 3 * exp(-j * w) + 4 * exp(-2j * w) + 5 * exp(-3j * w);

plot(w, abs(X));
