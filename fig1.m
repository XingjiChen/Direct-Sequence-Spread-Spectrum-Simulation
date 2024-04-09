clear all

snr=importdata('snr.mat');
dsss=importdata('bpsk1.mat');
nodsss=importdata('bpsknodsss.mat');


figure;
semilogy(snr,dsss,'-s');
hold on
semilogy(snr,nodsss,'-o');

legend('误比特率-dsss','误比特率-nodsss')

axis([-5 15 0 1]);
title('扩频通信与非扩频通信的性能比较')
xlabel('信噪比');
ylabel('误比特率');