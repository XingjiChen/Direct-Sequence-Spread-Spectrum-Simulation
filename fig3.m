clear all

snr=importdata('snr.mat');
dsssm=importdata('bpsk1.mat');
dssswalsh=importdata('ber1.mat');
dsssgold=importdata('ber2.mat');

figure;
semilogy(snr,dsssm,'-s');
hold on
semilogy(snr,dssswalsh,'-o');
hold on
semilogy(snr,dsssgold,'-*');
legend('误比特率-m-dsss','误比特率-walsh-dsss','误比特率-gold-dsss')

% axis([-5 12 0 1]);
title('不同扩频序列扩频通信性能比较')
xlabel('信噪比');
ylabel('误比特率');