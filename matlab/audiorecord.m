clear all;
close all;

recorder = audiorecorder(44100, 16, 1);
disp('Start speaking.');

recordblocking(recorder, 2);
audioarray = getaudiodata(recorder);
disp('Recording finished.');

b_short = int16(audioarray * 1000);
l = length(audioarray);

fid = fopen('audiorecord.h', 'w');
fprintf(fid, '#ifndef AUDIORECORD_H\n');
fprintf(fid, '#define AUDIORECORD_H\n\n');
fprintf(fid, '#define SPEECHBUF %d\n\n', l);
fprintf(fid, 'short Speech[SPEECHBUF+1] = {\n');
fprintf(fid, '%d, ', b_short(1:end-1));
fprintf(fid, '%d\n};\n\n', b_short(end));
fprintf(fid, '#endif\n');
fclose(fid);