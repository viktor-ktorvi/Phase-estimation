clc;
close all;
clear variables;

set(groot,'defaulttextinterpreter','latex');  
%% Vremenski domen
Fs = 2000; % Hz
t = (0:8191)/Fs; % s

%% Frekvencijski domen
N = 2^14;

my_phase = 60;

freqs = 1:0.05:100;

for i = 1:length(freqs)
    y = 0 + 1000 * cos(2*pi*freqs(i) * t(1:2048) + my_phase * pi / 180) + 1000 * 0.1 * rand;

%     y = y .* flattopwin(length(y))';
    [absY1, phaseY1] = my_fft(y, N);

    [maxval, index] = max(absY1);
    measured_phases(i) = phaseY1(index) / pi * 180;
    
%     if measured_phases(i) < 0
%        measured_phases(i) = measured_phases(i) + 180; 
%     end
end

figure;
plot(freqs, measured_phases)
title("Faze")
xlabel("f [Hz]")
ylabel("$arg(X(j2\pi f))$ [rad]")
hold on;
yline(my_phase, 'r')


function [absX1, phaseX1] = my_fft(x, N)

    X = fft(x, N);
    dc = X(1);
    desno = X(2:N/2 + 1); % jedan odbirak vise na kraju od levo
    levo = X(N/2 + 2:N);
    X = [levo, dc, desno];

    absX1 = abs([dc, desno] / length(x));
    absX1(2:end) = absX1(2:end) * 2;

    phaseX1 = angle([dc, desno]);

end