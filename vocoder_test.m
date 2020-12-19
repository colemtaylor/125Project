clear
clc

% set window lengths
L_window  = 256;
hop_in    = 64;
hop_out   = 128;

% load audio file
[audioIn, Fs] = audioread('gettysburg10.wav');
% Fs = 3000;
% audioIn = sin(2*pi*300*(0:1/Fs:2))';

audioOut = vocoder(audioIn, hop_in, hop_out, L_window);
soundsc(audioOut, Fs)
