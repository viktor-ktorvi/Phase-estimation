clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%% Ucitavanje

input_signal = dlmread('input100.txt')';
% input_signal = input_signal - mean(input_signal);
% fft_re_out = dlmread('fft_re_out_3Hz.txt');
% fft_im_out = dlmread('fft_im_out_3Hz.txt');

%% Vremenski domen
Fs = 2000;
t = 1/Fs * (0:length(input_signal) - 1)';

xlimit = 50;

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

figure;
sgtitle("Jednostrani spektar");

subplot(211)
plot(faxis1, absX1)
title("$|X(j2\pi f)|$")
xlabel("f [Hz]")
ylabel("$|X(j2\pi f)|$ [unit]")
xlim([0, xlimit])

subplot(212)
plot(faxis1, phaseX1);
title("$arg(X(j2\pi f))$")
xlabel("f [Hz]")
ylabel("$arg(X(j2\pi f))$ [rad]")
xlim([0, xlimit])

[max_val, max_index] = max(absX1(faxis1 < 30));
ph_18plus = phaseX1(faxis1 < 30);
ph_rad = ph_18plus(max_index)
ph_deg = ph_rad / pi * 180
