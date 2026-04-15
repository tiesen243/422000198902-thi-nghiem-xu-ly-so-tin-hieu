clear all;
close all;

Fs_target = 16000;
duration_sec = 2;
f_tri = 1000;             % Triangle-wave frequency (Hz)

% Bandpass spec: center = 4 kHz, bandwidth = 3 kHz
f_center = 4000;
bandwidth = 3000;
f1 = f_center - bandwidth / 2;   % 2500 Hz
f2 = f_center + bandwidth / 2;   % 5500 Hz

% Create 2-second triangle-wave input signal (no hardware required)
N_target = round(duration_sec * Fs_target);
t_out = (0:N_target-1)' / Fs_target;
x = 2 * abs(2 * mod(f_tri * t_out, 1) - 1) - 1;

% Design FIR bandpass filter
N = 200;  % Filter order
Wn = [f1, f2] / (Fs_target / 2);
b = fir1(N, Wn, 'bandpass');

% Filter signal
y = filter(b, 1, x);

% Convert filtered signal to int16 for C export
y_short = int16(max(min(y, 1), -1) * 32767);
L = length(y_short);

fid = fopen('extract_1.h', 'w');
fprintf(fid, '#ifndef EXTRACT_1_H\n');
fprintf(fid, '#define EXTRACT_1_H\n\n');
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

disp('Done: extract_1.h has been generated.');
