clear all;
close all;

Fs = 44000;
filename = 'music.mp3';

info = audioinfo(filename);
numSamples = min(round(2 * info.SampleRate), info.TotalSamples);

[y, Fs] = audioread(filename, [1, numSamples]);
y = y(:, 1); L0 = length(y); y0 = y';

y1 = y0(L0 - 44000:L0);

b_short = int16(y1 * 1000);
L = length(y1);

fid = fopen('extract.h', 'w');
fprintf(fid, '#ifndef EXTRACT_H\n');
fprintf(fid, '#define EXTRACT_H\n\n');
fprintf(fid, '#define SPEECHBUF %d\n\n', L);
fprintf(fid, 'short Speech[SPEECHBUF+1] = {\n');
fprintf(fid, '%d, ', b_short(1:end-1));
fprintf(fid, '%d\n};\n\n', b_short(end));
fprintf(fid, '#endif\n');
fclose(fid);