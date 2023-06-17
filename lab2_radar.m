% 1
% generati un semnal cu date de tip real 
% amplitudinea 1
% tMax = 0.05
% tMin = -0.05
% nSamples = 256
% linspace(tMin, tMAx, nSamples)
% a. generati semanlul
% b. generati subploturi in care frecventa semnalului este aceeasi 
% nSamples = 64, 32, 16, 8 -> nr esantioane


% frequency
RSP.f0 = 32;
tMin = 0.05;
tMax = -0.05;

RSP.Amplitude = 1;
RSP.nSamples = 256;  % frecventa de esantionare i guess
ts = linspace(tMin, tMax, RSP.nSamples);
xs = RSP.Amplitude * cos(2 * pi * RSP.f0 * ts);

figure(1) 
subplot(2, 2, 1);
plot(ts, xs, "linewidth", 2);


% 2
RSP.nSamples = 64;
t = linspace(tMin, tMax, RSP.nSamples);
x = RSP.Amplitude * cos(2 * pi * RSP.f0 * t);

subplot(2, 2, 2);
plot(ts, xs, 'k', "linewidth", 2);hold on 
plot(t, x, "linewidth", 2);hold on 
plot(t, x, "ro", "linewidth", 2);hold off


% 3
RSP.nSamples = 32;
t = linspace(tMin, tMax, RSP.nSamples);
x = RSP.Amplitude * cos(2 * pi * RSP.f0 * t);

subplot(2, 2, 3);
plot(ts, xs, 'k', "linewidth", 2);hold on 
plot(t, x, "linewidth", 2);hold on 
plot(t, x, "ro", "linewidth", 2);hold off


% 4
RSP.nSamples = 16;
t = linspace(tMin, tMax, RSP.nSamples);
x = RSP.Amplitude * cos(2 * pi * RSP.f0 * t);

subplot(2, 2, 4);
plot(ts, xs, 'k', "linewidth", 2);hold on 
plot(t, x, "linewidth", 2);hold on 
plot(t, x, "ro", "linewidth", 2);hold off


