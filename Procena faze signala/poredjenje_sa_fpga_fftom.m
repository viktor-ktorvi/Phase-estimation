clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%% Ucitavanje

input_signal = dlmread('samples_in_4Hz.txt')';
fft_re_out = dlmread('fft_re_out_3Hz.txt');
fft_im_out = dlmread('fft_im_out_3Hz.txt');

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
absX1 = absX1(1:2048) * length(input_signal) /2;
phaseX1 = phaseX1(1:2048);

out_abs = sqrt(fft_re_out.^2 + fft_im_out.^2);
out_phase = atan2(fft_im_out, fft_re_out);

figure;
subplot(211)
hold on;
plot(out_abs)
subplot(212)
hold on;
plot(out_phase)


subplot(211)
plot(absX1)
title("$|X(j2\pi f)|$")
xlabel("n [odb]")
ylabel("$|X(j2\pi f)|$ [unit]")

subplot(212)
plot(phaseX1);
title("$arg(X(j2\pi f))$")
xlabel("n [odb]")
ylabel("$arg(X(j2\pi f))$ [rad]")
%%
%%
X = fft(input_signal, N);
X = X(1:2048);

figure;

subplot(211)
hold on;
plot(fft_re_out);
plot(real(X));

subplot(212)
hold on;
plot(fft_im_out)
plot(imag(X))