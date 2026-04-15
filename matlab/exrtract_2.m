clear all;
close all;

Fs_target = 16000;
duration_sec = 2;

% PSK carrier and symbol settings
fc = 4000;      % Carrier frequency (Hz)
Rs = 1000;      % Symbol rate (symbols/sec)
M = 2;          % BPSK

% Bandpass spec to isolate the PSK carrier region
f_center = fc;
bandwidth = 3000;
f1 = f_center - bandwidth / 2;
f2 = f_center + bandwidth / 2;

% Simulate a 2-second PSK signal
N_target = round(duration_sec * Fs_target);
t = (0:N_target-1)' / Fs_target;

% Deterministic random data for repeatable output
rng(0);

% BPSK symbols: 0 -> phase 0, 1 -> phase pi
sps = max(1, round(Fs_target / Rs));
numSymbols = ceil(N_target / sps);
bits = randi([0 1], numSymbols, 1);
phases = pi * bits;
phaseStream = repelem(phases, sps);
phaseStream = phaseStream(1:N_target);

% Passband PSK waveform
x = cos(2 * pi * fc * t + phaseStream);

% FIR bandpass filter, order N = 300
N = 300;
Wn = [f1, f2] / (Fs_target / 2);
b = fir1(N, Wn, 'bandpass');

% Process simulated PSK signal
y = filter(b, 1, x);

% Convert filtered signal to int16 for C export
y_short = int16(max(min(y, 1), -1) * 32767);
L = length(y_short);

fid = fopen('exrtract_2.h', 'w');
fprintf(fid, '#ifndef EXRTRACT_2_H\n');
fprintf(fid, '#define EXRTRACT_2_H\n\n');
fprintf(fid, '#define SPEECHBUF %d\n\n', L);
fprintf(fid, 'short Speech[SPEECHBUF+1] = {\n');

chunkSize = 4096;
for k = 1:chunkSize:L
    e = min(k + chunkSize - 1, L);
    block = y_short(k:e);
    if e < L
        fprintf(fid, '%d, ', block);
    else
        if numel(block) > 1
            fprintf(fid, '%d, ', block(1:end-1));
        end
        fprintf(fid, '%d\n', block(end));
    end
end

fprintf(fid, '};\n\n');
fprintf(fid, '#endif\n');
fclose(fid);

disp('Done: exrtract_2.h has been generated.');