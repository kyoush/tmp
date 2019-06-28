[sig,Fs] = audioread('data/low_koe.wav');  % �M���� x �ɁA�T���v�����O���g���� Fs �ɓǂ݂��ށB

total = zeros(1024, 1);
for i = 1 : length(sig)/1024 - 1
   total = total + fft(sig(i*1024:i*1024+1023));
end
total = total/i;

subplot(2,1,1)
plot(sig);

N = length(total);
freq = 0: Fs/N:Fs-1/N;
subplot(2,1
db = 20 * log10(abs(total));
plot(freq, db)
semilogx(freq, db);
xlim([20, freq(N/2)]);