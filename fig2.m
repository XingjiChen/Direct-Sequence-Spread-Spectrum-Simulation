clear all

snr=importdata('snr.mat');
dsssbpsk=importdata('bpsk1.mat');
dsss4qam=importdata('4qam.mat');
dsss16qam=importdata('16qam2.mat');

figure;
semilogy(snr,dsssbpsk,'-s');
hold on
semilogy(snr,dsss4qam,'-o');
hold on
semilogy(snr,dsss16qam,'-*');
legend('误比特率-dsssbpsk','误比特率-dsss4qam','误比特率-dsss16qam')

axis([-5 12 0 1]);
title('不同调试方式扩频通信性能比较')
xlabel('信噪比');
ylabel('误比特率');