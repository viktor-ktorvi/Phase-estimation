function phi_hat = mle_phase_estimation(x, f0, Fs)
    n = 0:(length(x) - 1);

    f0_dig = f0 / Fs;

    sinus = sin(2 * pi * f0_dig * n);
    cosinus = cos(2 * pi * f0_dig * n);

    phi_hat = -atan(sum(x .* sinus) / sum(x .* cosinus));
end