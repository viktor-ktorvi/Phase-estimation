clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%%

% Ideje: 
%   - (tesko je reci, zasto bi ovo radilo?) da se smanji broj odbiraka (2048->1024 npr)
%   - (Ovo ne valja) da se smanji ucestanost odabiranja sto bi povecalo 
%   rezoluciju?
%   - (cini se da jeste mnogo bolje)da se poveca ucestanost odabiranja 
%   sto bi povecalo vremensku
%   rezoluciju
%   - da se usrednjavaju procene u okolnim tackama

xsize = 2048;
Fs = 4000;

t = 1/Fs * (1:xsize);

A = 6000;

N = 2^14;

naxis = 0:N/2;
faxis1 = naxis/(N/2) * Fs / 2;

freqs = 20:0.01:100;
phases = -pi/2:0.1:pi/2;

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
zlabel("$|$error$|$ [rad]")


% filtered_error = imgaussfilt(errors, 10);
% figure;
% surf(X,Y,filtered_error')
% title("Greska procene faze - filtrirano")
% xlabel("f [Hz]")
% ylabel("$\phi$ [rad]")
% zlabel("$|$error$|$ [rad]")