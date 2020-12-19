function y = vocoder(x, hop_in, hop_out, L_window)

hop_ratio = hop_out/hop_in;

audioIn = x;

% create window
win = sqrt(hanning(L_window,'periodic'));

% initilize arrays
unwrapdata  = 2*pi*hop_in*(0:L_window-1)'/L_window;
audioOut    = zeros(hop_out*floor(length(audioIn)*hop_ratio/hop_out), 1);
yangle      = zeros(L_window,1);
y_buffer  = zeros(L_window, 1);
ys_buffer = zeros(L_window+hop_out, 1);

% set initial index
index_in  = 1;
index_out = 1;
while index_in+hop_in < length(audioIn)
    
    % window audio with overlap
    y = audioIn(index_in:index_in+hop_in-1);
    y_buffer = [y_buffer(hop_in+1:end); y];

    % STFT
    ystft = fft(y_buffer.*win);
    
    % convert complex to magnitude and phase
    ymag       = abs(ystft);
    yprevangle = yangle;
    yangle     = angle(ystft);

    % vocoder logic
    yunwrap = (yangle - yprevangle) - unwrapdata;
    yunwrap = yunwrap - round(yunwrap/(2*pi))*2*pi;
    yunwrap = (yunwrap + unwrapdata) * hop_ratio;
    if index_in == 1
        ysangle = yangle;
    else
        ysangle = ysangle + yunwrap;
    end

    % convert back to complex
    ys = ymag .* complex(cos(ysangle), sin(ysangle));

    % inverse STFT
    ys_buffer = [ys_buffer(hop_out+1:end);zeros(hop_out, 1)] + ...
        [zeros(hop_out, 1); win.*real(ifft(ys))];

    audioOut(index_out: index_out+hop_out-1) = ys_buffer(1:hop_out);
    
    % move indexes to next hop
    index_in  = index_in + hop_in;
    index_out = index_out + hop_out;
end
y = audioOut;
end