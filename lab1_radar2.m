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
real_signal = A*cos(2*pi*f*time + phi);


% x then y 
figure(1);
subplot(3,1,1);  % 3- nr de randuri , 1- nr de coloane , 1- a cata coloana 
plot(time, real_signal);
xlabel('time');
ylabel('amplitude');

% figure(2);

% cu cat e mai scurt in timp, cu atat banda ocupata in grafic ca frecventa e mai mare 
% ->  se intinde pe mai mult 
% -> pentru ca sunt invers proportionale (?) 
A2 = 8;
phi2 = deg2rad(180);
real_signal2 = A2*cos(2*pi*f*time + phi2);

subplot(3,1,2);
plot(time, real_signal2);z
xlabel('time');
ylabel('amplitude');

real_signal3 = real_signal + real_signal2;
subplot(3,1,3)
plot(time, real_signal3);
ylim([-5 5])
xlabel('time');
ylabel('amplitude');


% 2 types of interference / noise
% inteferenta constructiva - aceeasi faza
% interferenta distructiva, diferenta de 180 


