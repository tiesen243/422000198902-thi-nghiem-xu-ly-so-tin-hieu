clear all;
close all;

filename = '1khz.mp3';
Fs_target = 16000;
duration_sec = 2;

% Bandpass spec: center = 4 kHz, bandwidth = 3 kHz
f_center = 4000;
bandwidth = 3000;
f1 = f_center - bandwidth / 2;   % 2500 Hz
f2 = f_center + bandwidth / 2;   % 5500 Hz

% Read only the first 2 seconds from the MP3 file
info = audioinfo(filename);
numSamplesIn = min(round(duration_sec * info.SampleRate), info.TotalSamples);
[x, Fs_in] = audioread(filename, [1, numSamplesIn]);

% Convert to mono if needed
if size(x, 2) > 1
    x = mean(x, 2);
end

% Resample to Fs = 16 kHz without toolbox dependency
N_target = round(duration_sec * Fs_target);
t_in = (0:length(x)-1)' / Fs_in;
t_out = (0:N_target-1)' / Fs_target;
x = interp1(t_in, x, t_out, 'linear', 0);

% FIR bandpass filter, order N = 300
N = 300;
Wn = [f1, f2] / (Fs_target / 2);
b = fir1(N, Wn, 'bandpass');

% Filter signal
y = filter(b, 1, x);

% Convert filtered signal to int16 for C export
y_short = int16(max(min(y, 1), -1) * 32767);
L = length(y_short);

fid = fopen('extract_3.h', 'w');
fprintf(fid, '#ifndef EXTRACT_3_H\n');
fprintf(fid, '#define EXTRACT_3_H\n\n');
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

disp('Done: extract_3.h has been generated.');
