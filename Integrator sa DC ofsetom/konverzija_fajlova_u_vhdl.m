clc;
close all;
clear variables;
%%

signal_txt = dlmread('signal_txt.txt');

figure;
plot(signal_txt)
title("Signal")
xlabel("n [odb]")
ylabel("signal [jedinica]")

fileID = fopen('signal_vhdl.txt','w');
save_to_file_vhdl(signal_txt, fileID)
fclose('all');
disp('Konvertovano')