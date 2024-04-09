%QAM调制
clear variable;
close all;

time=5;%循环次数

N = 1000;   %码元数量

gain = 10;  %扩频增益

%加扰使用的m序列的参数
mOrder = 5; %级数5级
feedBack = 75;%反馈系数67
fb=1e3;
fc=200e3;%载波频率
fs=fc*8;%采样频率

snr=-5:1:30;
for i=1:length(snr)
    ttlErr = 0;%初始化误比特数
    for j=1:time
        
    %生成QAM信号
    user = randi([0 15],1,1000);%
    qam = qammod(user,16);
    
    %扩频
    spread1 = spreadSpectrum(qam,gain);
    
    %加扰
    Mseq1 = MseqGen(mOrder,feedBack);
    Mseq1 = Mseq1(:);%获得m序列
    user1scarm = scarmbling(spread1,Mseq1);%扩频信号与m序列比特相乘
    
    %生成载波
    t=linspace(0,1/N,fs/N);
    carrier=cos(2*pi*fb*t);
    %载波调制
    %modulate = myModulate(qam(k,:),carrier);

    %通过高斯信道，添加高斯噪声
    power=powerCnt(carrier);
    user1send = awgn(user1scarm,snr(i),power/2.2);
    
    %接收方
    receive = user1send;
    
     %解调
%     demodulateRes = demodulate(receive,carrier);
%     res(k,:)=demodulateRes(1,:);
    %去扰
    user1Descarm = deScarmbling(receive,Mseq1);
    
    %解扩
    user1deDS = deSpreadqam(user1Descarm,gain);
    user0=qamdemod(user1deDS,16);
    %求误码率
    numErr = sum(user0~=user);
    ttlErr = ttlErr + numErr;
    end
    ttlBits = time*N;
    errRate(i) = ttlErr/ttlBits;%计算误比特率
end

figure;
semilogy(snr,errRate,'-s');
title('16QAM扩频误比特率');
xlabel('信噪比');
ylabel('误比特率');
axis([-5 12 0 1]);