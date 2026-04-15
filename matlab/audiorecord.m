clear all;
close all;

inputFile = 'music.mp3';
info = audioinfo(inputFile);
numSamples = min(round(2 * info.SampleRate), info.TotalSamples);
[audioarray, fs] = audioread(inputFile, [1, numSamples]);

if size(audioarray, 2) > 1
    audioarray = mean(audioarray, 2);
end

disp(['Loaded first 2 seconds from ', inputFile, ' at ', num2str(fs), ' Hz.']);

b_short = int16(max(min(audioarray, 1), -1) * 32767);
b_short = b_short(b_short ~= 0);

l = length(b_short);

fid = fopen('audiorecord.h', 'w');
fprintf(fid, '#ifndef AUDIORECORD_H\n');
fprintf(fid, '#define AUDIORECORD_H\n\n');
fprintf(fid, '#define SPEECHBUF %d\n\n', l);
fprintf(fid, 'short Speech[SPEECHBUF+1] = {\n');
fprintf(fid, '%d, ', b_short(1:end-1));
fprintf(fid, '%d\n};\n\n', b_short(end));
fprintf(fid, '#endif\n');
fclose(fid);