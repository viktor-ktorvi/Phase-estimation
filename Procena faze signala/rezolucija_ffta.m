clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%% Vremenski domen
Fs = 2000; % Hz
sim_duration = 50; % s
time = 1/Fs * (0:(Fs * sim_duration));
t = time;

n = 1;
A = 6000;

f = 100.123456 * (1:n); % Hz
phases = 1.2345 * (1:n);



x = 0; %+ 0.1 * A * randn(length(t), 1)';
for i = 1:n
    x = x + A/i * cos(2*pi* f(i) * t + phases(i));
end

xlimit = 100; % Hz

figure;
sgtitle("Vremenski domen")

subplot(211)
plot(t, x)
title("Ulazni signal")
ylabel("$x(t)$ [unit]")
xlabel("t [s]")

subplot(212)
ind1 = round(0.5 * length(t));
ind2 = round(0.505 * length(t));
plot(t(ind1:ind2), x(ind1:ind2))
title("Uvelicano")
xlabel("t [s]")
ylabel("$x(t)$ [unit]")
%% Jednostrani spektar - x.size = 2048, N = 16384

N = 2^14;

xsize = 2048;
[absX1, phaseX1] = my_fft(x(1:xsize), N);

naxis = 0:N/2;
faxis1 = naxis/(N/2) * Fs / 2;



[max_amp, max_index] = max(absX1);
mle_ph = mle_phase_estimation(x(1:xsize), faxis1(max_index), Fs);


fprintf("Za duzinu signala %d i broj tacaka FFT-a %d\n\n", xsize, N)

fprintf("Procena ucestanosti f = %3.3f\n", faxis1(max_index))
fprintf("Procena faze ph = %3.3f\n", phaseX1(max_index))
fprintf("ML procena faze ph = %3.3f\n", mle_ph)


fprintf("\nPrava ucestanost f = %3.3f\n", f(1))
fprintf("Prava faza ph = %3.3f\n", phases(1))
fprintf("Greska procene = %3.3f\n", abs(phaseX1(max_index) - phases(1)));

for cnt = 1:50
   fprintf("=") 
end
fprintf("\n")

figure;
sgtitle("Jednostrani spektar signala duzine " + xsize + " odbiraka" ...
    + newline + "u " + N + " tacaka FFT-a");

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




%% Jednostrani spektar - x.size = 2048, N = 2^

N = 2^17;

xsize = 2048;
[absX1, phaseX1] = my_fft(x(1:xsize), N);

naxis = 0:N/2;
faxis1 = naxis/(N/2) * Fs / 2;


[max_amp, max_index] = max(absX1);
mle_ph = mle_phase_estimation(x(1:xsize), faxis1(max_index), Fs);

fprintf("Za duzinu signala %d i broj tacaka FFT-a %d\n\n", xsize, N)

fprintf("Procena ucestanosti f = %3.3f\n", faxis1(max_index))
fprintf("Procena faze ph = %3.3f\n", phaseX1(max_index))
fprintf("ML procena faze ph = %3.3f\n", mle_ph)


fprintf("\nPrava ucestanost f = %3.3f\n", f(1))
fprintf("Prava faza ph = %3.3f\n", phases(1))
fprintf("Greska procene = %3.3f\n", abs(phaseX1(max_index) - phases(1)));

for cnt = 1:50
   fprintf("=") 
end
fprintf("\n")


figure;
sgtitle("Jednostrani spektar signala duzine " + xsize + " odbiraka" ...
    + newline + "u " + N + " tacaka FFT-a");

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



