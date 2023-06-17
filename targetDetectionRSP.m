
clear all
close all

% LFMCW input generated data
load('rawAdcData.mat')

%   speed of light [m/s]
    c0                          = 2.99792458108e8;
% number of FMCW ramps per Tx antenna    
    RSP.nEvalRampsPerTxAntenna  = 64;
% number of Rx channels    
    RSP.nChannels               = 4;
% number of samples per ramp    
    RSP.nSamples                = 256;
% number of Tx antennas    
    RSP.nTx                     = 3;
% frequency ramp start point [Hz]
    RSP.f0                      = 76.075e9;   
% frequency ramp end point [Hz]
    RSP.f1                      = 76.975e9;   
% waveform bandwidth
    RSP.BWD                     = (RSP.f1 - RSP.f0); 
% Pulse repetition interval [s]
    RSP.PRI                     = 57.8e-6;   
% range resolution    
    RSP.rangeRes_m              = c0/(2*RSP.BWD);
% Doppler resolution    
    RSP.dopRes_mps          = c0/((RSP.f1 + RSP.f0) * RSP.PRI * RSP.nEvalRampsPerTxAntenna * RSP.nTx);
% maximum Doppler    
    RSP.dopNyquist_mps          = RSP.dopRes_mps * RSP.nEvalRampsPerTxAntenna;
% unambiguous Doppler    
    RSP.unambiguousDoppler_mps = RSP.dopNyquist_mps/2;
%% Process Range
% initialize data matrix
    rangeSignal = zeros(RSP.nEvalRampsPerTxAntenna, RSP.nSamples, RSP.nChannels);
% process windowing function
    winRange = hanning(RSP.nSamples);
% process range FFT per Rx channel per ramp
% it is a function of no. of samples per ramp
    for indRx = 1:RSP.nChannels
        for indR = 1:RSP.nEvalRampsPerTxAntenna
            rangeSignal(indR,:,indRx) = fft(rawAdcData(indR,:,indRx).*winRange', [], 2);
        end
    end
% remove half of the samples/spectrum due to real valued input
    rangeSignal = rangeSignal(:, 1:RSP.nSamples/2, :);

    figure(1)
    Range_mag = 20*log10(abs(rangeSignal));            
    imagesc(0:RSP.rangeRes_m:(size(rangeSignal,2) - 1) * RSP.rangeRes_m,...
        0:(size(rangeSignal,1) - 1), squeeze(max(Range_mag,[],3)))
    title('Range Superposed Spectrum')
    set(gca,'ydir','normal');
    xlabel('Range [m]')
    ylabel('Ramp #')
    axis([0 (size(rangeSignal,2) - 1) * RSP.rangeRes_m 0 (size(rangeSignal,1) - 1)])
    
    figure(11)
    plot(0:RSP.rangeRes_m:(size(rangeSignal,2) - 1) * RSP.rangeRes_m,...
        squeeze(Range_mag(1,:,1)),'LineWidth',2)
    title('Range Spectrum - one Ramp')
    xlabel('Range [m]')
    ylabel('PSD [dB]')
    grid on
    axis tight
    
% target Range reference
    [3 3 sqrt(17^2 + (-7)^2)]
%% Process Range - Doppler map
    dopplerSignal = zeros(RSP.nEvalRampsPerTxAntenna, size(rangeSignal, 2), RSP.nChannels);
% prepare windowing coefficients
    winDoppler = hanning(RSP.nEvalRampsPerTxAntenna);
% process Doppler FFT
    for indRx = 1:RSP.nChannels
        for indR = 1:size(rangeSignal, 2)
            dopplerSignal(:, indR, indRx) = fft(rangeSignal(:, indR, indRx).* winDoppler,[],1);
        end
    end
% data scaling
    dopplerSignal = dopplerSignal / size(dopplerSignal,1);
    
    figure(2)
    Doppler_magdB = 20*log10(abs(dopplerSignal));
    imagesc(0:RSP.rangeRes_m:(size(dopplerSignal,2) - 1) * RSP.rangeRes_m,...
        (0:RSP.dopRes_mps:(size(dopplerSignal,1) - 1) * RSP.dopRes_mps),...
        squeeze(max(Doppler_magdB,[],3)))
    title('Range Doppler Superposed Spectrum')
    set(gca,'ydir','normal');
    xlabel('Range [m]')
    ylabel('Doppler [m/s]')
    
% target Doppler reference
    [5 2 -4]
%% Process Magnitude map
% magnitude for channel 1/Rx1
    Doppler_mag = abs(dopplerSignal);
    magnitudeData = squeeze(Doppler_mag(:,:,1));
%% process fixed threshold for the range - Doppler map
% Pfa = 10e-6 => k = 6
% miu = 2*sigma^2 = 2*var
    k = 6;
    miu = 2*var(dopplerSignal,[],2);
    scalingFactor = 2^25;
    
    T = max(max(squeeze(k*log(10)*miu)));
    Threshold = T/scalingFactor;

    figure(3)
    thresholddB = 20*log10(Threshold);
    thresholddB = thresholddB*ones(RSP.nEvalRampsPerTxAntenna,RSP.nSamples/2);
    magRx1dB = Doppler_magdB(:,:,1);
% Comparator    
    indexMagnitude = (magRx1dB > thresholddB);
    magRx1dB(indexMagnitude == 0) = 0;
    contour(0:RSP.rangeRes_m:(size(magRx1dB,2) - 1) * RSP.rangeRes_m,...
        (0:RSP.dopRes_mps:(size(magRx1dB,1) - 1) * RSP.dopRes_mps), magRx1dB);       
    title('Overlaped Magnitude and Threshold')
    xlabel('Range [m]')
    ylabel('Doppler [m/s]')
    
    figure(31)
    binRange = 19;
    plot((0:RSP.dopRes_mps:(size(dopplerSignal,1) - 1) * RSP.dopRes_mps),...
        squeeze(Doppler_magdB(:,binRange,1)),'b','LineWidth',2), hold on
    plot((0:RSP.dopRes_mps:(size(dopplerSignal,1) - 1) * RSP.dopRes_mps),...
        thresholddB(:,binRange),'g','LineWidth',2), hold off
    title('Doppler Spectrum - over Range')
    xlabel('Doppler [m/s]')
    ylabel('PSD [dB]')
    legend('PSD','Fixed Threshold')
    grid on
    axis tight
    
    figure(32)
    binRange = 112;
    plot((0:RSP.dopRes_mps:(size(dopplerSignal,1) - 1) * RSP.dopRes_mps),...
        squeeze(Doppler_magdB(:,binRange,1)),'b','LineWidth',2), hold on
    plot((0:RSP.dopRes_mps:(size(dopplerSignal,1) - 1) * RSP.dopRes_mps),...
        thresholddB(:,binRange),'g','LineWidth',2), hold off
    title('Doppler Spectrum - over Range')
    xlabel('Doppler [m/s]')
    ylabel('PSD [dB]')
    legend('PSD','Fixed Threshold','Location','Best')
    grid on
    axis tight
    
    
return

