% bpsk调制解调仿真
% data：2022年7月 author：北京理工大学·信息与电子学院·李润洲
% 环境： MATLAB R2016a
clc;
close all;
%参数设置
EBN0 = 10:11;%信噪比（dB）
myber = [];%用来记录实际误码率
len = 100; %码元个数
span = 6;
sps = 16;%samples per symbol
b = rcosdesign(0.35,span,sps,'sqrt');

for ebn0 = EBN0
    
bit_rate = 1000;%1s内1000个比特
symbol_rate = 1000;%二进制相位键控的符号率应该与比特率相同
fc = 20000;%载波频率
fs = sps.*bit_rate;%也就是16000hz，信号频率中最高是8000hz

%信号源
msg_source = randi(2,1,len)-1;%随机信号

%发送机
bipolar_msg_source = 2.*msg_source-1;%0,1映射为-1,1

%根升余弦滤波器
rcos_msg_source = upfirdn(bipolar_msg_source,b,sps);%上采样16倍

% figure;
% plot(rcos_msg_source);
% title('time');
% 
% figure;
% plot(abs(fft(rcos_msg_source)));
% title('freq');

%载波调制
n = 1:length(rcos_msg_source);
rcos_msg_source_carrier = rcos_msg_source.*cos(2*pi*fc.*n/fs);

% figure;
% plot(rcos_msg_source_carrier);
% title('调制信号时域波形');
% 
% figure;
% plot(abs(fft(rcos_msg_source_carrier)));
% title('调制信号频域波形');


%信道
snr = 10*log10(2)+ebn0-10*log10(16);
rcos_msg_source_carrier_addnoise = awgn(rcos_msg_source_carrier,snr,'measured');
% figure;
% plot(abs(fft(rcos_msg_source_carrier_addnoise)));
% title('加噪后的调制信号频域波形');

%接收机
%匹配滤波器
%%载波恢复，生成本地载波
rcos_msg_source_addnoise = rcos_msg_source_carrier_addnoise.*cos(2*pi*fc.*n/fs);
% figure;
% plot(abs(fft(rcos_msg_source_addnoise)));
% title('本地载波频域波形');

%低通滤波
% fir_lp = fir1(128,0.1);
% rcos_msg_source_lp = filter(fir_lp,1,rcos_msg_source_addnoise);


%开始匹配滤波
rcos_msg_source_MF = filter(b,1,rcos_msg_source_addnoise);

% figure;
% plot(rcos_msg_source_MF);
% title('匹配滤波后的时域波形');
% figure;
% plot(abs(fft(rcos_msg_source_MF)));
% title('匹配滤波后的频域波形');

%%%最佳采样点、
%选取最佳采样点
decision_site = 160-128/2; %(96+128+96)/2 = 160,三个滤波器延时48,96，48
%每个symbol选一个判决点
rcos_msg_source_MF_option = rcos_msg_source_MF(decision_site+1:sps:end);
%%%判决
rcos_msg_source_MF_option_sign = sign(rcos_msg_source_MF_option);
% figure; 
% plot(rcos_msg_source_MF_option_sign,'-*');
% title('判决结果');

eyediagram(rcos_msg_source,sps);
title('发射端眼图');
eyediagram(rcos_msg_source_MF,sps);
title('接收端眼图');

scatterplot(rcos_msg_source(48+1:16:end-48));
title('bpsk星座图');
axis([-1 1 -0.5 0.5]);


%误码性能
%误码率=传输中的误码/所传输的总码数*100%
%rcos_msg_source_MF_option_sign,bipolar_msg_source
totalnum = length(rcos_msg_source_MF_option_sign);
wrong = 0;
for i = 1:totalnum
    if bipolar_msg_source(i)~=rcos_msg_source_MF_option_sign(i)
        wrong = wrong + 1;
    end
end


myber = [myber,wrong/totalnum];
end

% ber = berawgn(EBN0,'psk',2,'nondiff');
% figure;
% plot(EBN0,10*log10(myber),'r');%红色是实际值
% hold on;
% plot(EBN0,10*log10(ber),'g');%绿色是理论值
% legend('实际误码率','理论误码率')


