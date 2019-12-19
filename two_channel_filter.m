%implementation of 2 channel filter bank
clc
clear all
close all

%define filter
h0 = [1/2 1/2]; %lpf in analysis side
h1 = [1/2 -1/2]; %hpf in analysis side
g0 = 2.5* h0; %lpf in synthesis side
g1 = -2.5*h1; %hpf in synthesis side

%define input signal
t = linspace(0,1,100);
x = sin(2*pi*5*t);

%implement filter bank
%analysis
x1 = filter(h0,1,x);
x2 = downsample(x1,2);
x2 = zeros(1,length(x2));
x3 = filter(h1,1,x);
x4 = downsample(x3,2);
%synthesis
x5 = upsample(x2,2);
x6 = upsample(x4,2);
x7 = filter(g0,1,x5);
x8 = filter(g1,1,x6);
y = x7+x8;

%plot
subplot(211),plot(t,x);
xlabel('t'),ylabel('amplitude'),title('input')
subplot(212), plot(t,y);
xlabel('t'),ylabel('amplitude'),title('output')



