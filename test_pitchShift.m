clear
close all

load train;

v = [-130, -10];

%Test Time stretch
%N = ceil((10/1000)*fs); %Corresponds to 10ms of signal
N = 100;
out = ola(y,hann(N),N,2); %Using a hanning window allows for no normalization
figure;
spectrogram(out, [], [], [], Fs);
caxis(v);
title('OLA, Train Whistle with Time Stretch by 2');
% soundsc(out,Fs)


%Test Pitch Shift Up
%N = ceil((10/1000)*fs); %Corresponds to 10ms of signal
N = 100;
out = ola(y,hann(N),N,2); %Using a hanning window allows for no normalization
figure;
spectrogram(out, [], [], [], Fs*2);
caxis(c);
title('OLA, Train Whistle with pitch Shift Up');
soundsc(out,Fs*2)
