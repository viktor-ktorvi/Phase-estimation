clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
%% Vremenski domen
Fs = 2000; % Hz
sim_duration = 2; % s
time = 1/Fs * (0:(Fs * sim_duration));
t = time;

n = 5;
A = 6000;

f = 57.723 * (1:n); % Hz
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

N = 2^19;

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
xlim([0, 500])

subplot(212)
plot(faxis1, phaseX1);
title("$arg(X(j2\pi f))$")
xlabel("f [Hz]")
ylabel("$arg(X(j2\pi f))$ [rad]")
xlim([0, 500])
%% MLE


for i = 1:n
    freq = f(i)
    % freq = round(f(i), 1)
    phase_est = mle_phase_estimation(x, freq, Fs);

    fprintf("Ucestanost = %2.2f Hz\nProcena faze = %2.4f rad\nPrava faza = %2.4f rad\n\n", f(i), phase_est, phases(i))
end

function phi_hat = mle_phase_estimation(x, f0, Fs)
    n = 0:(length(x) - 1);

    f0_dig = f0 / Fs;

    sinus = sin(2 * pi * f0_dig * n);
    cosinus = cos(2 * pi * f0_dig * n);

    phi_hat = -atan(sum(x .* sinus) / sum(x .* cosinus));
end









































































































































































































