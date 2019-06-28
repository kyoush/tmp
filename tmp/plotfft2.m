clear;
[x,Fs] = audioread('data/high_hue.wav');   % �M���� x �ɁA�T���v�����O���g���� Fs �ɓǂ݂���

n = length(x);   % �M�� x �̗v�f�� n
k = 0:n-1;
time = k/Fs;   % ���Ԏ��x�N�g����ݒ�

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
N = length(sig);   % �M�� sig �̗v�f�� N
K = 0:N-1;
freq = K*Fs/N;   % ���g�����x�N�g����ݒ�
db = 20*log10(sig);   % �M�� sig �̐�Βl����葊�Ή������x���ɕϊ�

subplot(2,1,2)
semilogx(freq,db);   % x����10���Ƃ���ΐ��X�P�[���Ńv���b�g
grid on
xlabel('Frequency [Hz]'); ylabel('Power [dB]');
xlim([20 20000]); %ylim([-100 100]);   % �\��������g���͈͂ƃp���[�͈͂�ݒ�

% �O���t��̃p���[���ő�ƂȂ�ʒu�ɂ��̎��̎��g����\��
[power_max,freq_max] = max(db);
text(freq(freq_max),power_max,['\leftarrow' num2str(round(freq(freq_max))) ' Hz']);

% x���̖ڐ���̐ݒ� 
ax = gca;
ax.XTick = [50 100 200 400 800 1600 3200 6400 12800 20000];
%xticks([40 100 200 400 800 1600 3200 6400 12800 20000]);