%BPSK����ȥ��Ƶ
clear variable;
close all;

time=5;%ѭ������

N = 1000;   %��Ԫ����

gain = 10;  %��Ƶ����

%����ʹ�õ�m���еĲ���
mOrder = 5; %����5��
feedBack = 67;%����ϵ��67

fc=200e3;%�ز�Ƶ��
fs=fc*8;%����Ƶ��

snr=-5:1:30;
for i=1:length(snr)
    ttlErr = 0;%��ʼ���������
    for j=1:time
    %����˫������Ƭ
    user1 = genBipolar(N);
    
%     %��Ƶ
%     spread1 = spreadSpectrum(user1,gain);
%     
%     %����
%     Mseq1 = MseqGen(mOrder,feedBack);
%     Mseq1 = Mseq1(:);%���m����
%     user1scarm = scarmbling(spread1,Mseq1);%��Ƶ�ź���m���б������
    
    
    %�����ز�
    t=linspace(0,1/N,fs/N);
    carrier=cos(2*pi*fc*t);
    
    %BPSK��ʽ����
    user1modulate = myModulate(user1,carrier);
    
    %ͨ����˹�ŵ�����Ӹ�˹����
    power=powerCnt(carrier);
    user1send = awgn(user1modulate,snr(i),power);
    
    %���շ�
    receive = user1send;
    
    %���
    demodulateRes = demodulate(receive,carrier);
    
%     %ȥ��
%     user1Descarm = deScarmbling(demodulateRes,Mseq1);
%     
%     %����
%     user1deDS = deSpreadSpectrum(user1Descarm,gain);
    
    %��������
    numErr = sum(demodulateRes~=user1);
    ttlErr = ttlErr + numErr;
    end
    ttlBits = time*N;
    errRate(i) = ttlErr/ttlBits;%�����������
end

figure;
semilogy(snr,errRate,'-s');
title('BPSKȥ��Ƶ�������');
xlabel('�����');
ylabel('�������');
axis([-5 15 0 1]);