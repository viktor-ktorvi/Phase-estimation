clc;
close all;
clear variables;
%% Parametri
Fs = 2000; % Hz
f = 100; % Hz
A = 1000;
DC = 10;
epsilon = 10;
w = 2*pi*f;
%% Modifikovani integrator
s = tf('s');
G = 1/(s + epsilon);
W = 1/s;

figure;
margin(W)
title("Idealni integrator")

figure;
margin(G)
title("Modifikovani integrator")

freq_rest_at_w = freqresp(G, w);
gain_at_w = abs(freq_rest_at_w);

%% Signal
t = (0:2047) / Fs;

x = A*cos(2*pi*f * t) + 2000 * cos(2*pi*f/2 *t + pi/3);

[y_mod_integ_DC, t] = lsim(G, x + DC, t);
[y_integ_DC, t] = lsim(W, x + DC, t);
[y_integ, t] = lsim(W, x, t);


figure;
sgtitle("Idealna integracija")

subplot(211)
plot(t, x);
xlabel("t [s]")
ylabel("signal [unit]")
title("Ulaz")

subplot(212)
plot(t, y_integ);
xlabel("t [s]")
ylabel("signal [unit]")
title("Izlaz")

figure;
sgtitle("Idealna integracija sa DC ofsetom")

subplot(211)
plot(t, x);
xlabel("t [s]")
ylabel("signal [unit]")
title("Ulaz")

subplot(212)
plot(t, y_integ_DC);
xlabel("t [s]")
ylabel("signal [unit]")
title("Izlaz")

figure;
plot(t, y_integ, t, y_mod_integ_DC)
title("Integracija sa modifikacijom - poredjenje")
xlabel("t [s]")
ylabel("signal [unit]")
legend("idealno", "sa modifikacijom")

