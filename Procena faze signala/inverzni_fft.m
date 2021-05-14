clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%% Vremenski domen
Fs = 2000; % Hz
sim_duration = 2; % s
time = 1/Fs * (0:(Fs * sim_duration));
N = 2^11;

t = time(1:N);

n = 5;
A = 6000;

f = 50 * (1:n); % Hz
phases = pi/6 * (1:n);

x = A/2 + 0.1 * A * randn;
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

[absX1, phaseX1] = my_fft(x, N);

naxis = 0:N/2;
faxis1 = naxis/(N/2) * Fs / 2;

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
%% FFT

X = fft(x);
f_levo = 30;
f_desno = 70;
X(1:f_levo) = 0;
X(end - f_levo:end) = 0;
X(f_desno:end - f_desno) = 0;

absX2 = abs(X);
phaseX2 = angle(X);

figure;

subplot(211)
plot(absX2)
title("absX2")
xlabel("N [odb]")


subplot(212)
plot(phaseX2)
title("phaseX2")
xlabel("N [odb]")


%% IFFT

y = ifft(X);


figure;
sgtitle("Vremenski domen")

subplot(211)
plot(t, y)
title("Signal")
ylabel("$y(t)$ [unit]")
xlabel("t [s]")

subplot(212)
ind1 = round(0.5 * length(t));
ind2 = round(0.55 * length(t));
plot(t(ind1:ind2), y(ind1:ind2))
title("Uvelicano")
xlabel("t [s]")
ylabel("$y(t)$ [unit]")
%%
[absY1, phaseY1] = my_fft(y, N);

figure;
sgtitle("Jednostrani spektar");

subplot(211)
plot(faxis1, absY1)
title("$|Y(j2\pi f)|$")
xlabel("f [Hz]")
ylabel("$|Y(j2\pi f)|$ [unit]")

subplot(212)
plot(faxis1, phaseY1);
title("$arg(Y(j2\pi f))$")
xlabel("f [Hz]")
ylabel("$arg(Y(j2\pi f))$ [rad]")
