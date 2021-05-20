clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%% Vremenski domen
Fs = 2000; % Hz
sim_duration = 5; % s
time = 1/Fs * (0:(Fs * sim_duration));
t = time;

n = 1;
A = 6000;


N = 2^14;

xsize = 2048;

phase = 1.12345; % rad

freqs = (15:0.1:250)';
f_hats = zeros(length(freqs), 1);
phase_hats = zeros(length(freqs), 1);
tic
for i = 1:length(freqs)
    x = A * cos(2*pi*freqs(i)*t + phase);
    [absX1, phaseX1] = my_fft(x(1:xsize), N);
    naxis = 0:N/2;
    faxis1 = naxis/(N/2) * Fs / 2;


    [max_amp, max_index] = max(absX1);
    
    f_hat = faxis1(max_index);
    phase_hat = phaseX1(max_index);
    
    f_hats(i) = f_hat;
    phase_hats(i) = phase_hat;
end
toc
fprintf("\n\n")
%% Greska ucestanosti
f_errors = abs(freqs - f_hats);
figure;
plot(freqs, f_errors);
title("Greska procene frekvencije")
xlabel("f [Hz]")
ylabel("greska [Hz]")

unit = "Hz";
errors = f_errors;

my_stats(Fs, xsize, N, unit, errors, "Procena ucestanosti")

%% Greska faze
phase_errors = abs(phase_hats - phase);

figure;
plot(freqs, phase_errors);
title("Greska procene faze")
xlabel("f [Hz]")
ylabel("greska [rad]")

unit = "rad";
errors = phase_errors;

my_stats(Fs, xsize, N, unit, errors, "Procena faze")



