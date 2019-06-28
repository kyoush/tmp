clear;
[x,Fs] = audioread('data/high_hue.wav');   % 信号を x に、サンプリング周波数を Fs に読みこむ

n = length(x);   % 信号 x の要素数 n
k = 0:n-1;
time = k/Fs;   % 時間軸ベクトルを設定

subplot(2,1,1)
plot(time, x); xlabel('Time [s]'); ylabel('Amplitude');   


cnt = 0;
SUMSig = 0;
Frame_shift = 1024;
Frame_length = 8192;
TotalFrameNum = n - Frame_length;
 for frame = 1 : Frame_shift : TotalFrameNum
     SIG = x(frame:frame+Frame_length-1).*hanning(Frame_length);
     sig = abs(fft(SIG,Frame_length*2));
     SUMSig = SUMSig + sig;
     cnt = cnt + 1;
 end

sig = SUMSig/cnt;

%%
N = length(sig);   % 信号 sig の要素数 N
K = 0:N-1;
freq = K*Fs/N;   % 周波数軸ベクトルを設定
db = 20*log10(sig);   % 信号 sig の絶対値を取り相対音圧レベルに変換

subplot(2,1,2)
semilogx(freq,db);   % x軸を10を底とする対数スケールでプロット
grid on
xlabel('Frequency [Hz]'); ylabel('Power [dB]');
xlim([20 20000]); %ylim([-100 100]);   % 表示する周波数範囲とパワー範囲を設定

% グラフ上のパワーが最大となる位置にその時の周波数を表示
[power_max,freq_max] = max(db);
text(freq(freq_max),power_max,['\leftarrow' num2str(round(freq(freq_max))) ' Hz']);

% x軸の目盛りの設定 
ax = gca;
ax.XTick = [50 100 200 400 800 1600 3200 6400 12800 20000];
%xticks([40 100 200 400 800 1600 3200 6400 12800 20000]);