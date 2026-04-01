function [db, mag, pha, grd, w] = freqz_m(b, a)
    if nargin < 2
        a = 1;
    end
    N = 501; % Number of frequency points
    [H, w] = freqz(b, a, N);
    mag = abs(H);                % Magnitude response
    db = 20 * log10(mag + eps);    % Magnitude in dB, add eps to avoid log(0)
    pha = angle(H);              % Phase response
    grd = grpdelay(b, a, N);     % Group delay
end
