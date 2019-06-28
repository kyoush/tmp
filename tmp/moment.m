clear

[sig,Fs] = audioread('data/high_koe.wav');  % 信号を x に、サンプリング周波数を Fs に読みこむ。

SIG = sig(1:8192) .* hanning(8192);
teki = abs(fft(SIG));

% subplot(2,1,1);
% plot(sig);

N = length(teki);
freq = 0: Fs/N:Fs-1/N;
% subplot(2,1,2);
db = 20 * log10(abs(teki));
plot(freq, db);
semilogx(freq, db);

grid on
xlabel('Frequency [Hz]'); ylabel('Power [dB]');
xlim([20, 20000]);


% グラフ上のパワーが最大となる位置にその時の周波数を表示
[power_max,freq_max] = max(db);
text(freq(freq_max),power_max,['\leftarrow' num2str(round(freq(freq_max))) ' Hz']);

% x軸の目盛りの設定 
ax = gca;
ax.XTick = [50 100 200 400 800 1600 3200 6400 12800 20000];
%xticks([40 100 200 400 800 1600 3200 6400 12800 20000]);