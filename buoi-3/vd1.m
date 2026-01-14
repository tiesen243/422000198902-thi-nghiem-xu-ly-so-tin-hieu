clc;
clear all;
close all;

w = -pi:0.01:pi;
X = exp(j * w) ./ (exp(j * w) - 0.5 * ones(1, length(w)));

plot(w, abs(X));
