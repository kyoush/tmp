clear
close all

sig = kasan(S);
N = length(sig);   % 信号 sig の要素数 N
K = 0:N-1;
freq = K*Fs/N;   % 周波数軸ベクトルを設定
db = 20*log10(sig);   % 信号 sig の絶対値を取り相対音圧レベルに変換
semilogx(freq,db);   % x軸を10を底とする対数スケールでプロット

function sig = kasan(x)
n = length(x);
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


end