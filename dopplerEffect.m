function dopplerEffectLab3
% Create the app
app = uifigure('Name', 'Sine Wave Generator', 'Position', [100 100 800 500]);
grid = uigridlayout(app, [1 2]);

% setup
% f_max = ...;
% t_min = ...;
% f_min = ...;
% t_max = ...;
% step = ...;
% frame = ...;

% Create the axes for the plot
% plot 1
ax1 = uiaxes(grid);
ax1.Title.String = 'Semnal Emis';
ax1.XLim = [0 frame];
ax1.YLim = [-1 1];
ax1.Position = [50 50 300 400];
%{
% plot 2
ax2 = uiaxes(grid);
ax2.Title.String = 'Semnal Receptionat';
ax2.XLim = [0 frame];
ax2.YLim = [-1 1];
ax2.Position = [400 50 300 400];

% plot 3
ax3 = uiaxes(grid);
ax3.Title.String = 'Semnal Multiplicat';
ax3.XLim = [0 frame];
ax3.YLim = [-2 2];
ax3.Position = [750 50 300 400];
%}

% setup source and transmitter speed
vs = 30;
vr = 0;
c = 343;

% Create the initial sine wave
% signal1_freq
frequency = 1000;
%signal2_freq
frequency2 = 2 * frequency;
%signal3_freq
% freq1 = ...;
% freq2 = ...;
% Create the time
t = 0:step:frame;
% Create the signals
%y1 = ...;
%y2 = ...;
%y3 = ...;
% Plot the signals
% plot(ax1, t, y1);
% plot(ax2, t, y2);
% plot(ax3, t, y3);

% Create the slider to adjust the frequency
freqSlider = uislider(grid, 'Value', frequency, 'Limits', [300 2000], 'Position', [89 207 211 7], 'ValueChangedFcn', @(s,e) updateFrequency(s.Value));

% Add two uilabel components to display the values of frequency and frequency2
freqLabel1 = uilabel(grid, 'Text', sprintf('FrecventaEmisa: %d Hz', frequency));
freqLabel1.Position = [125 150 150 22];

freqLabel2 = uilabel(grid, 'Text', sprintf('FrecventaReceptionata: %d Hz', frequency2));
freqLabel2.Position = [475 150 150 22];




% Define a function that can compute the doppler frequency
function frequency2 = testFunc(newFreq)
    % calculate the doppler shift frequency - use the formula
    frequency2 = newFreq;
    
end

% Define the function to update the sine wave
function updateSineWave()
    % signal1
    % signal2
    % signal3
    
    % signal1 - plot
    % signal2 - plot
    % signal3 - plot
    
end

% Define the callback for the slider
function updateFrequencyCallback(slider, ~)
    frequency = slider.Value;
    % frequency2 = testFunc(slider.Value);
    % freq1 = ...;
    % freq2 = ...;
    updateSineWave();
    freqLabel1.Text = sprintf('FrecventaEmisa: %.2f Hz', frequency);
    % freqLabel2.Text = sprintf('FrecventaReceptionata: %.2f Hz', frequency2);
    
    
end




% Assign the callback to the slider
freqSlider.ValueChangedFcn = @(slider, event) updateFrequencyCallback(slider, event);

end
