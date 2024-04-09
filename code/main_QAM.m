%QAM����
clear variable;
close all;

time=5;%ѭ������

N = 1000;   %��Ԫ����

gain = 10;  %��Ƶ����

%����ʹ�õ�m���еĲ���
mOrder = 5; %����5��
feedBack = 75;%����ϵ��67
fb=1e3;
fc=200e3;%�ز�Ƶ��
fs=fc*8;%����Ƶ��

snr=-5:1:30;
for i=1:length(snr)
    ttlErr = 0;%��ʼ���������
    for j=1:time
        
    %����QAM�ź�
    user = randi([0 15],1,1000);%
    qam = qammod(user,16);
    
    %��Ƶ
    spread1 = spreadSpectrum(qam,gain);
    
    %����
    Mseq1 = MseqGen(mOrder,feedBack);
    Mseq1 = Mseq1(:);%���m����
    user1scarm = scarmbling(spread1,Mseq1);%��Ƶ�ź���m���б������
    
    %�����ز�
    t=linspace(0,1/N,fs/N);
    carrier=cos(2*pi*fb*t);
    %�ز�����
    %modulate = myModulate(qam(k,:),carrier);

    %ͨ����˹�ŵ�����Ӹ�˹����
    power=powerCnt(carrier);
    user1send = awgn(user1scarm,snr(i),power/2.2);
    
    %���շ�
    receive = user1send;
    
     %���
%     demodulateRes = demodulate(receive,carrier);
%     res(k,:)=demodulateRes(1,:);
    %ȥ��
    user1Descarm = deScarmbling(receive,Mseq1);
    
    %����
    user1deDS = deSpreadqam(user1Descarm,gain);
    user0=qamdemod(user1deDS,16);
    %��������
    numErr = sum(user0~=user);
    ttlErr = ttlErr + numErr;
    end
    ttlBits = time*N;
    errRate(i) = ttlErr/ttlBits;%�����������
end

figure;
semilogy(snr,errRate,'-s');
title('16QAM��Ƶ�������');
xlabel('�����');
ylabel('�������');
axis([-5 12 0 1]);