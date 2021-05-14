clc;
close all;
clear all;
%%
Fs = 2000; % Hz
sim_duration = 2; % s
time = 1/Fs * (0:(Fs * sim_duration));
t = time;
N = 2048;
f = 50;
A = 6000;
x = A + A/2 * cos(2*pi *f * t + pi/3);

X = fft(x, length(x));
y = ifft(X, length(x));

sum(x - y)

