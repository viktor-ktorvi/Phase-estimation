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
t = time;

n = 1;
A = 6000;


N = 2^15;

xsize = 1024;

phases = (-0.9*pi:0.1:0.9*pi)';
freqs = (15:0.1:100)';

naxis = 0:N/2;
faxis1 = naxis/(N/2) * Fs / 2;

phase_errors = zeros(length(freqs), length(phases));

tic
for i = 1:length(freqs)
    for j = 1:length(phases)
        x = A * cos(2*pi*freqs(i)*t + phases(j)) + 0.1 * A * rand(1, length(t));;
        
        [absX1, phaseX1] = my_fft(x(1:xsize), N);

        [max_amp, max_index] = max(absX1);

        f_hat = faxis1(max_index);
        phase_hat = phaseX1(max_index);
        
        phase_errors(i, j) = abs(phase_hat - phases(j));
    end
end
toc
fprintf("\n\n")
%%
[X,Y] = meshgrid(freqs,phases);

figure;
surf(X,Y,phase_errors')
colormap summer
shading interp
title("Greska procene faze")
xlabel("f [Hz]")
ylabel("$\phi$ [rad]")
zlabel("$|$greska$|$ [rad]")

unit = "rad";
errors = phase_errors;

my_stats(Fs, xsize, N, unit, errors, "Procena faze [" + unit + "]")

unit = "deg";
errors = phase_errors * 180 / pi;

my_stats(Fs, xsize, N, unit, errors, "Procena faze [" + unit + "]")


