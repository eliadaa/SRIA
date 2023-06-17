% generati un semnal "real_signal" cu data de tip real cu urmatoarele
% atribute:
% A 5
% frecventa 5Hz
% faza semnalului e 0
% semnalul este generat in timpul tMax = 2s cu pas step de 0.01 secunde
% generati semnalul
% modificati A, dazza, frecventa semnalului

A = 8; % amplitudinea
f = 2; % frecventa in Hz
% phi = deg2rad(0); % faza in radiani -> pentru cos because cos(0) is 1  
% phi = deg2rad(270); % sin or -90 
phi = deg2rad(0);
tMax = 2; % timpul in secunde
%time = start : increment : final;
increment = 0.01; 
time = 0:increment:tMax;

% lungimea de unda = lambda = viteza luminii / frecventa
% 


noise = randn(size(time))*1.5;
% x = A * cos(2*pi*fs*t + phi);
real_signal = A*cos(2*pi*f*time + phi)+noise;

% x then y 
plot(time, real_signal);
xlabel('time');
ylabel('amplitude');
