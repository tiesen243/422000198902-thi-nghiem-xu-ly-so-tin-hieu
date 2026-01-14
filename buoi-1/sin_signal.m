function [n, x] = sin_signal(N, k, m)
    % sin_signal - Generates a sinusoidal signal
    %
    % Syntax: [n, x] = sin_signal(N, k, m)
    %
    % Inputs:
    %    N - Number of samples per unit interval
    %    k - Frequency scaling factor
    %    m - Maximum time value
    %
    % Outputs:
    %    n - Sample indices (1 to length of signal)
    %    x - Sinusoidal signal values: sin(2*pi*n.*t)

    t = 0:k / N:m;
    n = 1:1:length(t);
    x = sin(2 * pi * t);
end

