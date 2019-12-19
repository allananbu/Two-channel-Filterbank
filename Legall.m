clc
clear all
close all

%LeGall filter 
%define filter coefficient
h0 = 1/8*[-1 2 6 2 -1];
h1 = 1/2*[1 -2 1];
g0 = 1/2*[1 2 1];
g1 = 1/8*[1 2 -6 2 1];

%implementation of 2 channel filter bank

%define input signal
t = linspace(0,1,100);
x = sin(2*pi*5*t);
%x = square(2*pi*5*t);

%implement filter bank
%analysis
x1 = filter(h0,1,x);
x2 = downsample(x1,2);
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

%%
% Frequency response for the filter coefficients

[H1,f1] = freqz(h0,1, 1024,100);
[H2,f2] = freqz(h1,1,1024,100);
[H3,f3] = freqz(g0,1,1024,100);
[H4,f4] = freqz(g1,1,1024,100);
figure, plot(f1,abs(H1),f2,abs(H2),f3,abs(H3),f4,abs(H4)), legend('LPF','HPF','LPF','HPF');
