clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
%% Vremenski domen
Fs = 2000; % Hz
t = (0:2047) / Fs; % s

f0 = 57; % Hz
phi = 
x = 17*cos(2*pi*f0 * t + 1.3) + 0.1 *randn;


figure;
plot(t, x)
title("x(t)")
xlabel("t [s]")
ylabel("x [unit]")
legend("x")

%% Jednostrani spektar

N = 2^11;

[absX1, phaseX1] = my_fft(x, N);

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
%% MLE

n = 0:(length(x) - 1);

f0_dig = f0 / Fs;

sinus = sin(2 * pi * f0_dig * n);
cosinus = cos(2 * pi * f0_dig * n);

phi_hat = -atan(sum(x .* sinus) / sum(x .* cosinus));



function phi_hat = mle_phase_estimation(x, f0, Fs)
    
end









































































































































































































