clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%% Ucitavanje

input_signal = dlmread('samples_in_5Hz.txt')';
% fft_re_out = dlmread('fft_re_out_3Hz.txt');
% fft_im_out = dlmread('fft_im_out_3Hz.txt');

%% Vremenski domen
Fs = 2000;
t = 1/Fs * (0:length(input_signal) - 1)';


figure;
plot(t, input_signal);
title("Input signal")
xlabel("t [s]")
ylabel("signal [unit]")
%% Frekvencijski domen
N = 2^15;
naxis = 0:N/2;
faxis1 = naxis/(N/2) * Fs / 2;
[absX1, phaseX1] = my_fft(input_signal, N);
