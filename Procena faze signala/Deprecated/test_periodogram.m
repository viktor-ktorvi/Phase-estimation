clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%% Vremenski domen
% Zakljucak: faza linearno zavisi duzini prozora i ucestanosti pa je nagib faze veci za
% veci prozor, a manji za manji prozor - stoga je greska u proceni
% ucestanosti manja po fazu signala jer je nagib fazne karakteristike manji
% (https://ccrma.stanford.edu/~jos/sasp/Rectangular_Window.html)
Fs = 2000; % Hz

xsize = 2048;
xsmall = 512;

time = 1/Fs * (0:(xsize - 1));
t = time;
N = 2^15;

n = 2;
A = 6000;

f = 57.723 * (1:n); % Hz
phases = pi/6 * (1:n);

% x = 0.1 * A * randn(1, length(t));
x = 0;
for i = 1:n
    x = x + A/i * cos(2*pi* f(i) * t + phases(i));
end

figure;
sgtitle("Vremenski domen")

subplot(211)
plot(t, x)
title("Ulazni signal")
ylabel("$x(t)$ [unit]")
xlabel("t [s]")

subplot(212)
ind1 = round(0.5 * length(t));
ind2 = round(0.55 * length(t));
plot(t(ind1:ind2), x(ind1:ind2))
title("Uvelicano")
xlabel("t [s]")
ylabel("$x(t)$ [unit]")
%% Jednostrani spektar
xlimit = 200;
[absX1, phaseX1] = my_fft(x, N);

[pxx,wpxx] = periodogram(x,[],N);
fpxx = wpxx / pi * Fs/2;

pxx = pxx / max(pxx) * max(absX1);
[pmax_val, pmax_index] = max(pxx);
fpxx(pmax_index)


naxis = 0:N/2;
faxis1 = naxis/(N/2) * Fs / 2;

figure;
sgtitle("Jednostrani spektar");

subplot(211)
plot(faxis1, absX1, fpxx, pxx)
title("$|X(j2\pi f)|$")
xlabel("f [Hz]")
ylabel("$|X(j2\pi f)|$ [unit]")
xlim([0, xlimit])
legend("fft", "periodogram")

subplot(212)
plot(faxis1, phaseX1);
title("$arg(X(j2\pi f))$")
xlabel("f [Hz]")
ylabel("$arg(X(j2\pi f))$ [rad]")
xlim([0, xlimit])
