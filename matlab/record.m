clear all;
close all;

N = 100;
cutoff = 0.068;
b = fir1(N, cutoff);
freqz(b, 1);

b_short = int16(b * 32767);

fid = fopen('record.h', 'w');
fprintf(fid, '#ifndef RECORD_H\n');
fprintf(fid, '#define RECORD_H\n\n');
fprintf(fid, '#define N %d\n\n', N);
fprintf(fid, 'short h[N+1] = {\n');
fprintf(fid, '%d, ', b_short(1:end-1));
fprintf(fid, '%d\n};\n\n', b_short(end));
fprintf(fid, '#endif\n');
fclose(fid);