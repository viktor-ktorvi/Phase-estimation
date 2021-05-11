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