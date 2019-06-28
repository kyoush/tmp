clear
close all

sig = kasan(S);
N = length(sig);   % �M�� sig �̗v�f�� N
K = 0:N-1;
freq = K*Fs/N;   % ���g�����x�N�g����ݒ�
db = 20*log10(sig);   % �M�� sig �̐�Βl����葊�Ή������x���ɕϊ�
semilogx(freq,db);   % x����10���Ƃ���ΐ��X�P�[���Ńv���b�g

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