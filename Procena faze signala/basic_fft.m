clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
%% Vremenski domen
Fs = 2000; % Hz
t = (0:20000) / Fs; % s

x = 20 + 10*sin(2*pi*500 * t) +17*cos(2*pi*300 * t + 1.3);


figure;
plot(t, x)
title("x(t)")
xlabel("t [s]")
ylabel("x [unit]")
legend("x")

%% Frekvencijski domen
N = 2048;

X = fft(x, N);
dc = X(1);
desno = X(2:N/2 + 1); % jedan odbirak vise na kraju od levo
levo = X(N/2 + 2:N);
X = [levo, dc, desno];

absX2 = abs(X/length(x));

% identicno se dobije
% phaseX = atan2(imag(X), real(X));
phaseX2 = angle(X);

absX1 = abs([dc, desno] / length(x));
absX1(2:end) = absX1(2:end) * 2;

phaseX1 = angle([dc, desno]);

%% Dvostrani spektar
n = -(N/2 - 1):N/2;
faxis2 = n / N * Fs;

figure;
sgtitle("Dvostrani spektar");

subplot(211)
plot(faxis2, absX2)
title("$|X(j2\pi f)|$")
xlabel("f [Hz]")
ylabel("$|X(j2\pi f)|$ [unit]")


subplot(212)
plot(faxis2, phaseX2)
title("$arg(X(j2\pi f))$")
xlabel("f [Hz]")
ylabel("$arg(X(j2\pi f))$ [rad]")
%% Jednostrani spektar
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
