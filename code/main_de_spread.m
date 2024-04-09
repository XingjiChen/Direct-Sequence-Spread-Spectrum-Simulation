%BPSK调制去扩频
clear variable;
close all;

time=5;%循环次数

N = 1000;   %码元数量

gain = 10;  %扩频增益

%加扰使用的m序列的参数
mOrder = 5; %级数5级
feedBack = 67;%反馈系数67

fc=200e3;%载波频率
fs=fc*8;%采样频率

snr=-5:1:30;
for i=1:length(snr)
    ttlErr = 0;%初始化误比特数
    for j=1:time
    %生成双极性码片
    user1 = genBipolar(N);
    
%     %扩频
%     spread1 = spreadSpectrum(user1,gain);
%     
%     %加扰
%     Mseq1 = MseqGen(mOrder,feedBack);
%     Mseq1 = Mseq1(:);%获得m序列
%     user1scarm = scarmbling(spread1,Mseq1);%扩频信号与m序列比特相乘
    
    
    %生成载波
    t=linspace(0,1/N,fs/N);
    carrier=cos(2*pi*fc*t);
    
    %BPSK方式调制
    user1modulate = myModulate(user1,carrier);
    
    %通过高斯信道，添加高斯噪声
    power=powerCnt(carrier);
    user1send = awgn(user1modulate,snr(i),power);
    
    %接收方
    receive = user1send;
    
    %解调
    demodulateRes = demodulate(receive,carrier);
    
%     %去扰
%     user1Descarm = deScarmbling(demodulateRes,Mseq1);
%     
%     %解扩
%     user1deDS = deSpreadSpectrum(user1Descarm,gain);
    
    %求误码率
    numErr = sum(demodulateRes~=user1);
    ttlErr = ttlErr + numErr;
    end
    ttlBits = time*N;
    errRate(i) = ttlErr/ttlBits;%计算误比特率
end

figure;
semilogy(snr,errRate,'-s');
title('BPSK去扩频误比特率');
xlabel('信噪比');
ylabel('误比特率');
axis([-5 15 0 1]);