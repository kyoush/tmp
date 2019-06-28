% clear

[sig,Fs] = audioread('data/low_koe.wav');  % �M���� x �ɁA�T���v�����O���g���� Fs �ɓǂ݂��ށB

% tmp = sig(433:433+4095);
% sig2 =fft(tmp);

total = 0;
cnt = 0;
for i = 1 : length(sig) - 8191
    SIG = sig(i:i+8191) .* hanning(8192);
    teki = fft(SIG);
    teki2 = abs(teki);
    total = total + teki2;
    cnt = cnt + 1;
end
total = total/cnt;

subplot(2,1,1);
plot(sig);

N = length(total);
freq = 0: Fs/N:Fs-1/N;
subplot(2,1,2);
db = 20 * log10(abs(total));
plot(freq, db);
semilogx(freq, db);
grid on
xlabel('Frequency [Hz]'); ylabel('Power [dB]');
xlim([20, 20000]);


% �O���t��̃p���[���ő�ƂȂ�ʒu�ɂ��̎��̎��g����\��
[power_max,freq_max] = max(db);
text(freq(freq_max),power_max,['\leftarrow' num2str(round(freq(freq_max))) ' Hz']);

% x���̖ڐ���̐ݒ� 
ax = gca;
ax.XTick = [50 100 200 400 800 1600 3200 6400 12800 20000];
%xticks([40 100 200 400 800 1600 3200 6400 12800 20000]);