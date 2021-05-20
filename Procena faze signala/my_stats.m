function my_stats(Fs, xsize, N, unit, errors, title)

    fprintf(title)
    fprintf("\n")

    for cnt = 1:60
       fprintf("-") 
    end
    fprintf("\n")
    
    fprintf("Fs = %4.1f Hz,\t xsize = %d odb,\tN = %d odb\n", Fs, xsize, N)
    for cnt = 1:60
       fprintf("-") 
    end
    fprintf("\n")
    fprintf("E(error) =\n%20.5f %s\n", mean(errors(:)), unit)
    fprintf("median(error) =\n%20.5f %s\n", median(errors(:)), unit)
    fprintf("Var(error) =\n%20.5f %s^2\n", var(errors(:)), unit)
    fprintf("std(error) =\n%20.5f %s\n", std(errors(:)), unit)
    fprintf("max(error) =\n%20.5f %s\n", max(errors(:)), unit)
    fprintf("min(error) =\n%20.5f %s\n", min(errors(:)), unit)


    for cnt = 1:60
       fprintf("=") 
    end
    fprintf("\n\n\n")

end
