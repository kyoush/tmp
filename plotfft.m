clear
close all

load('short_jura531_2.mat');

l = 531/1000;     % ���� m
r = 29.9/2/1000;    % ���a m
E = 66.45*10^9;        % �����O��
I = pi/4*r^4;       % �f�ʂQ�����[�����g
A = pi*r^2;         % �f�ʐ� m^2
% g = 271/1000;     % ����  kg
% S = A*l;            % �̐�  m^3
q = 2644;            % ���x  kg/m^3
pm = 1/(l^2)*sqrt(E*I/(q*A));
fm = zeros(1, 10);
km = [0 4.73 7.8532 10.9956 14.1371 17.2787 20.4203 23.5619 26.7035 29.8451];

for i = 1:10
    fm(i) = pm*((km(i))^2)/(2*pi);    % �ŗL�p�U����
end

for i = 1:10
    disp(fm(i))
end

sig = kasan(S);
N = length(sig);   % �M�� sig �̗v�f�� N
K = 0:N-1;
freq = K*Fs/N;   % ���g�����x�N�g����ݒ�
db = 20*log10(sig);   % �M�� sig �̐�Βl����葊�Ή������x���ɕϊ�
semilogx(freq,db);   % x����10���Ƃ���ΐ��X�P�[���Ńv���b�g
xlim([20 20000]);
grid on
ylabel('power [dB]');
xlabel('freq [Hz]');

xticks(fm)
aa = zeros(1, 10);
for i = 1:10
    disp(num2str(fm(i)))
    aa(i) = num2str(fm(i));
end
xticklabels({'aa', 'bb'});

hold on
y = -80:0.1:40;
for i = 1:10
    x = ones(1, length(y));
    x = x .* fm(i);
    semilogx(x, y)
end


function sig = kasan(x)
n = length(x);
cnt = 0;
SUMSig = 0;
Frame_shift = 1024;
Frame_length = 8192;
TotalFrameNum = n - Frame_length;
 for frame = 1 : Frame_shift : TotalFrameNum
     SIG = x(frame:frame+Frame_length-1) .* hanning(Frame_length);
     sig = abs(fft(SIG,Frame_length*2));
     SUMSig = SUMSig + sig;
     cnt = cnt + 1;
 end

sig = SUMSig/cnt;
end