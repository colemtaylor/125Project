function signalOut = ola(signalIn,window,N, alpha)
%function signalOut = ola(signalIn,N, alpha)
%
% This function implements a time-domain time stretching algorithm known as
% OLA (Overlap-Add).
%
% Inputs:
% signalIn - Original Audio Signal
% window - Window Being Applied to Frames
% N - Length of Each Frame in Samples
% alpha - Stretching Factor Being Applied to signal

Hs = N/2; %First Use a Constant (Can implement Cross Correlation Later)
Ha = Hs/alpha;

numFrames = ceil((length(signalIn)-N)/Ha);
xm = zeros(numFrames,N);
windowedFrames = zeros(numFrames,N);
signalOut = zeros(1,Hs*(numFrames-1)+N);
for i = 1:numFrames
    xm(i,:) = signalIn((Ha*(i-1)+1):(Ha*(i-1))+N);
    windowedFrames(i,:) = (window' .* xm(i,:));
    signalOut(Hs*(i-1)+1:(Hs*(i-1))+N) = signalOut(Hs*(i-1)+1:(Hs*(i-1))+N) + windowedFrames(i,:);
end

end
