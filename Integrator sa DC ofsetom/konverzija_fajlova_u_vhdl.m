clc;
close all;
clear variables;
%%

signal_txt = dlmread('signal_txt.txt');
% signal_txt = int16(signal_txt);
%%
figure;
plot(signal_txt)
title("Signal")
xlabel("n [odb]")
ylabel("signal [jedinica]")
%%
fileID = fopen('Signali/signal_vhdl.txt','w');
save_to_file_vhdl(signal_txt, fileID)
fclose('all');
disp('Konvertovano')