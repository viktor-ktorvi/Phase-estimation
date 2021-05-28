clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%%
L = 2048;
Fs = 2000;
w = hamming(L)';

figure;
plot(w);
title("Prozor")
xlabel("n [odb]");
ylabel("w[n] [unit]");

N = 2^15;
[absX1, phaseX1] = my_fft(w, N);

n = 0:N/2;
faxis1 = n/(N/2) * Fs / 2;

figure;
sgtitle("Jednostrani spektar");

subplot(211)
plot(faxis1, absX1)
title("$|X(j2\pi f)|$")
xlabel("f [Hz]")
ylabel("$|X(j2\pi f)|$ [unit]")

subplot(212)
plot(faxis1, phaseX1);
title("$arg(X(j2\pi f))$")
xlabel("f [Hz]")
ylabel("$arg(X(j2\pi f))$ [rad]")
