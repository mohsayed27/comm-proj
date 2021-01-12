% Read 3 files
audioOneFilename = 'French.mp3';
audioTwoFilename = 'Spanish.mp3';
audioThreeFilename = 'English.mp3';
[x1, SR1] = audioread(audioOneFilename);
[x2, SR2] = audioread(audioTwoFilename);
[x3, SR3] = audioread(audioThreeFilename);

% Check for equal sampling rate 
assert(SR1 == SR2 && SR2 == SR3, 'Error in sampling Rate, please resapmle until all are equal'); 

figure(1); % To plot the three audio signals in Freq Domain
% For each signal:
% Get length 
% Get Fourier Transform
% Get one of the two parts (of FT) to represent the signal
% plot it

nX1 = length(x1); 
X1 = fft(x1, nX1);  % FFT for x1
rX1 = X1(1:nX1/2);
xfX1 = SR1 * (0:nX1 / 2 - 1) / nX1;
subplot(3,1,1);
plot(xfX1 ,abs(rX1));
title('First audio X1[n]')
xlabel('Frequency in HZ')
ylabel('Amplitude')

nX2 = length(x2);
X2 = fft(x2, nX2);
rX2 = X2(1:nX2/2);
xfX2 = SR2 * (0:nX2 / 2 - 1) / nX2;
subplot(3,1,2);
plot(xfX2 ,abs(rX2));
title('Second audio X2[n]')
xlabel('Frequency in HZ')
ylabel('Amplitude')

nX3 = length(x3);
X3 = fft(x3, nX3);
rX3 = X3(1:nX3/2);
xfX3 = SR3 * (0:nX3 / 2 - 1) / nX3;
subplot(3,1,3);
plot(xfX3 ,abs(rX3));
title('Third audio X3[n]')
xlabel('Frequency in HZ')
ylabel('Amplitude')

nMax = 0;
if (length(x1) > nMax)
    nMax = length(x1);
end

if (length(x2) > nMax)
    nMax = length(x2);
end

if (length(x3) > nMax)
    nMax = length(x3);
end

s = zeros(1,nMax);

w1 = 2*pi*150000;
w2 = 2*pi*320000;

timeInSec1 = length(x1) / SR1;
Ts1 = 1 / SR1;
Dt1 = 0 : Ts1 : timeInSec1 - Ts1;

for i = 1:length(x1)
    s(i) = s(i) + x1(i) * cos(Dt1(i) * w1);
end

timeInSec2 = length(x2) / SR2;
Ts2 = 1 / SR2;
Dt2 = 0 : Ts2 : timeInSec2 - Ts2;

for i = 1:length(x2)
    s(i) = s(i) + x2(i) * cos(Dt2(i) * w2);
end

timeInSec3 = length(x3) / SR3;
Ts3 = 1 / SR3;
Dt3 = 0 : Ts3 : timeInSec3 - Ts3;

for i = 1:length(x3)
    s(i) = s(i) + x3(i) * sin(Dt(i) * w2);
end



% % Plot x1 in freq domain
% nfftX1 = length(x1);
% ffX1 = fft(x1,nfftX1);
% fffX1 = ffX1(1:nfftX1/2);
% xfftX1 = SR1 * (0:nfftX1 / 2 - 1) / nfftX1;
% subplot(4,1,1);
% plot(xfftX1 ,abs(fffX1));
% title('First Message (x1[n])')
% xlabel('Frequency in HZ')
% ylabel('Amplitude')
% 
% % Plot x2 in freq domain
% 
% nfftX2 = length(x2);
% ffX2 = fft(x2,nfftX2);
% fffX2 = ffX2(1:nfftX2/2);
% xfftX2 = SR2 * (0:nfftX2 / 2 - 1) / nfftX2;
% subplot(4,1,2);
% plot(xfftX2 ,abs(fffX2));
% title('Second Message (x2[n])')
% xlabel('Frequency in HZ')
% ylabel('Amplitude')
% 
% % Intializing values
% X = x2; %to intialized the size
% attenuation = 0.1;
% frequency = 2*pi*160000;
% timeInSec = length(x1) / SR1;
% Ts = 1 / SR1;
% Dt = 0 : Ts : timeInSec - Ts;
% 
% % Hiding x1 in x2 by making shift of x1 in freq domain
% 
% for n = 1:length(Dt)
%     X(n) = x2(n) + attenuation * x1(n) * cos( frequency * Dt(n) );
% end
% 
% % Plot x3 in freq domain
% 
% nfftX3 = length(X);
% ffX3 = fft(X,nfftX3);
% fffX3 = ffX3(1:nfftX3/2);
% xfftX3 = SR2 * (0:nfftX3 / 2 - 1) / nfftX3;
% subplot(4,1,3);
% plot(xfftX3 ,abs(fffX3));
% title('Combined Signal (X[n])')
% xlabel('Frequency in HZ')
% ylabel('Amplitude')
% 
% % Output Hide message
% audiowrite('Hide.wav',X,44100);
% 
% 
% % Restoring hiden message by multiplying by cos again 
% Y = X; %to intialized the size
% 
% for n = 1:length(Dt)
%    Y(n) = X(n) * cos( frequency * Dt(n) );
% end
% 
% % Apply low pass filter to remove freq of x2
% fNorm = 2000 / (SR2/2);
% [b,a] = butter(10, fNorm, 'low');
% Y = filtfilt(b, a, Y);
% 
% % Plot x4 in freq domain
% 
% nfftX4 = length(Y);
% ffX4 = fft(Y,nfftX4);
% fffX4 = ffX4(1:nfftX4/2);
% xfftX4 = SR2 * (0:nfftX4 / 2 - 1) / nfftX4;
% subplot(4,1,4);
% plot(xfftX4 ,abs(fffX4));
% title('Hidden Signal (x1[n])')
% xlabel('Frequency in HZ')
% % Plot log(FFT(X)) vs samples
% figure(2);
% nX3 = (1: nfftX3);
% plot(nX3 ,log10(ffX3));
% title('Combined Signal (X[n])')
% ylabel('log10(abs(fft(X)))')
% xlabel('Sample')
% % Plot log(Amplitude) vs freq 
% figure(3);
% plot(xfftX3 ,log10(abs(fffX3)));
% title('Combined Signal (X[n])')
% xlabel('Frequency in HZ')
% ylabel('log10(Amplitude)')
% 
% % Extracting audio1 back from whole audio2 
% Yo = x1; %to intialized the size
% for n = 1:length(Dt)
%     Yo(n) = Y(n);
% end
% audiowrite('Reveal.wav',Yo,44100);

