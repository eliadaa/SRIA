% frecventa 0-5000Hz
% plot(t, y)
clear all;
close all;

Fs = 44000;
Ts = 1/Fs;
f0 = 0;
f1 = 5000;
t = 0:Ts:2;
t1 = 2;

y = chirp(t,f0,t1,f1);
plot(t, y)
xlim([0,0.4])
% sound(y)

figure;
specgram(y, 1024, Fs)
ylim([0,5000])

% 5000, t, t1 = 2
f0 = 5000;
f1 = 0;
t1 = 2;
y2 = chirp(t, f0, t1, f1);
figure;
plot(t, y2)
xlim([1.8,2])

f0 = 0;
f1 = 2000;
y3 = chirp(t, f0, t1, f1);

f0 = 2000;
f1 = 0;
y4 = chirp(t, f0, t1, f1);

chirp=[y, y2, y3, y4];
figure;
specgram(chirp)



