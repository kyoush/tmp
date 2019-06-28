clear
Fs=48000;
T=2;
s=0;
S=pa_wavplayrecord(s, 0, Fs, Fs*T, 1, 1, 0, 'asio');
N = Fs*T;
freq = 0: Fs/(Fs*T-1):Fs;

figure(5)
plot(S)
figure(6)

semilogx(freq, 20*log10(abs(fft(S))))
xlim([20 20000])