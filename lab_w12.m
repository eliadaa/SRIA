%Generati 2 semnale "real_signal" cu date de tip real cu urm atribute
%Ampl 5
%Frecv 5Hz
%Faza semn 0
%semnal este generat in timpul tMax=2 secunde cu un pas step = 0.01 secunde
%generati semanlul
%modificati ampl, faza, frecv
% x= A*cos(2*pi*fs*t+phi)
Fs=512;
T=1/Fs;
t=0:T:1-T;
A1 = 1; %ampl
A2= 0.5;
A3=0.25;

f1 = 10; %frecv Hz
f2 = 15;
f3 = 60;

%phi1 = deg2rad(0); %faza in radiani
%phi2 = deg2rad(180)
tMax1 = 2;%timpul in secunde
tMax2 = 2;
tMax3=2;
increment1 = 0.01; %incrementul in secunde 
increment2= 0.01;
increment3=0.01;
%time = start:increment:final
%time1 = 0:increment1:tMax1;
%time2 = 0:increment2:tMax2;
%time3 = 0:increment3:tMax3;
real_signal1=A1*cos(2*pi*f1*t)+randn(size(t))*0;
real_signal2=A2*cos(2*pi*f2*t)+randn(size(t))*0;
%real_signal3=A3*cos(2*pi*f3*t)+randn(size(t))*0;
%real_signal3=A3*exp(i*2*pi*f3*t)+randn(size(t))*0;


%x=real_signal1+real_signal2+real_signal3;

x = real_signal1 .* real_signal2;

N=length(x);
f=(Fs/N)*(0:(N/2)); %frequency vector
X=abs(fft(x)/N); %compute the FFT and normalize
figure(1)
subplot(5,1,1)
plot(t,real_signal1)
xlabel('time');
ylabel('amplitude');
subplot(5,1,2)
plot(t,real_signal2)
xlabel('time');
ylabel('amplitude');
subplot(5,1,3)
plot(t,real_signal3)
xlabel('time');
ylabel('amplitude');
subplot(5,1,4)
plot(t,x)
xlabel('time');
ylabel('amplitude');
subplot(5,1,5)
% plot(f,X(1:N/2+1))

plot(X)

xlabel('f');
ylabel('amplitude');