clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%%
xsize = 1024;
Fs = 2000;

t = 1/Fs * (1:xsize);

A = 6000;

N = 2^15;

naxis = 0:N/2;
faxis1 = naxis/(N/2) * Fs / 2;

freqs = 5:0.01:100;
phases = -pi:0.1:pi;

errors = zeros(length(freqs), length(phases));
tic
for i = 1:length(freqs)
    for j = 1:length(phases)
        x = A * cos(2 * pi * freqs(i)*t + phases(j));
        
        [absX1, phaseX1] = my_fft(x, N);
        [max_amp, max_index] = max(absX1);

        errors(i, j) = abs(phaseX1(max_index) - phases(j));
        
    end
end
toc
%% Plot

[X,Y] = meshgrid(freqs,phases);

figure;
surf(X,Y,errors')
title("Greska procene faze")
xlabel("f [Hz]")
ylabel("$\phi$ [rad]")
