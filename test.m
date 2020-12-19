clear
close all

fs = 8000;
t = 0:1/fs:2;
signal = sin(440*2*pi.*t);
soundsc(signal,fs);

%Testing OLA Shrinking
%N = ceil((10/1000)*fs); %Corresponds to 10ms of signal
N = 100;
out = ola(signal,hann(N),N,0.5); %Using a hanning window allows for no normalization
soundsc(out,fs)

%Testing OLA Shrinking
%N = ceil((10/1000)*fs); %Corresponds to 10ms of signal
N = 100;
out = ola(signal,hann(N),N,2); %Using a hanning window allows for no normalization
soundsc(out,fs)
