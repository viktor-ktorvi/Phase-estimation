% clc;
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
Fs = 2000;

t = 1/Fs * (0:xsize-1);

A = 6000;

N = 2^14;

naxis = 0:N/2;
faxis1 = naxis/(N/2) * Fs / 2;

freqs = 20:0.01:100;
phases = -pi/2:0.2:pi/2;

errors = zeros(length(freqs), length(phases));
tic
for i = 1:length(freqs)
    for j = 1:length(phases)
        x = A * cos(2 * pi * freqs(i)*t + phases(j));
        
        [absX1, phaseX1] = my_fft(x, N);
        [max_amp, max_index] = max(absX1);
        
        phase_est = phaseX1(max_index);
        

        errors(i, j) = abs(phase_est - phases(j));
        
    end
end
toc
%% Plot
close all

[X,Y] = meshgrid(freqs,phases);

figure;
surf(X,Y,errors')
colormap summer
shading interp
title("Greska procene faze")
xlabel("f [Hz]")
ylabel("$\phi$ [rad]")
zlabel("$|$greska$|$ [rad]")

fprintf("Srednja greska za sve faze i ucestanosti =\n%1.3f [rad]\n%1.3f [deg]\n"...
    , mean(errors(:)), 180/pi * mean(errors(:)))
fprintf("Maksimalna izmerena greska =\n%1.3f [rad]\n%1.3f [deg]\n",...
    max(errors(:)), 180/pi * max(errors(:)))
fprintf("Minimalna izmerena greska =\n%1.3f [rad]\n%1.3f [deg]\n",...
    min(errors(:)), 180/pi * min(errors(:)))
fprintf("Medijana greske =\n%1.3f [rad]\n%1.3f [deg]\n\n",...
    median(errors(:)), 180/pi * median(errors(:)))



filtered_error = imgaussfilt(errors, 10);
figure;
surf(X,Y,filtered_error')
colormap summer
shading interp
title("Greska procene faze - filtrirano")
xlabel("f [Hz]")
ylabel("$\phi$ [rad]")
zlabel("$|$greska$|$ [rad]")

figure;
histogram(errors(:))
title("Histogram gresaka")
xlabel("Greska [rad]")
xline(mean(errors(:)), 'LineWidth', 3, 'Color', 'r')
legend("histogram", "sr. vrednost")