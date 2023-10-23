
% Load the data from 'ES1_emg.mat'
load('ES1_emg.mat');

% Define frequency cutoffs
lowFreq = 30; % Lower cutoff frequency
highFreq = 450; % Upper cutoff frequency

% Calculate filter length in samples
fs = 2000; % Sampling frequency
nyquist = fs / 2;
lowCutoff = lowFreq / nyquist;
highCutoff = highFreq / nyquist;
filterOrder = 100; % Filter order
t_signal = (0:length(Es1_emg.matrix(:,1))-1)/fs;

% Create the FIR filter
b = fir1(filterOrder, [lowCutoff, highCutoff]);

% Apply the filter to the EMG signal
filteredEMG = filtfilt(b, 1, Es1_emg.matrix(:,1));

% Plot the original EMG signal (unfiltered) in blue
figure;
plot(t_signal, Es1_emg.matrix(:, 1), 'b');
hold on;

% Plot the filtered EMG signal in red
plot(t_signal, filteredEMG, 'r');

% Add labels and title
xlabel('Time (ms)');
ylabel('EMG Signal (mV)');
title('Original vs. Filtered EMG Signal');
legend('Unfiltered', 'Filtered');

hold off;

% Rectify the filtered EMG signal, meaning consider only the positive values of the output
rectifiedSignal = abs(filteredEMG);

% Create a new plot for the rectified signal
figure;
plot(t_signal,rectifiedSignal);
title('Rectified Signal and Envelope');
xlabel('Time(ms)');
ylabel('Amplitude');
hold on;

% Create another plot for the envelope
freq_low=4;
freqCutOff=freq_low/nyquist;
b_low=fir1(filterOrder,freqCutOff,'low');
envelope = filtfilt(b_low,1,rectifiedSignal);
plot(t_signal,envelope, 'r');
legend('Rectified Signal', 'Envelope');
hold off;

% Set the maximum frequency (fmax) and calculate the new sampling frequency (newfs)
div_factor = 2;
f_max = 450;
new_fs = fs / div_factor ;

% Check if newfs > 2*fmax, Nyquist theorem is satisfied, 
% so you can use new_fs for downsampling the envelope
if new_fs > 2*f_max
    downsampledEnvelope = downsample(envelope, div_factor);
end

% Extract the accelerometer - X signal
accelerometer_X = Es1_emg.matrix(:, 2);  % Column 2 represents Deltoid Accelerometer - X
accelerometer_Y=Es1_emg.matrix(:,3);
% Calculate time based on the accelerometer's sampling frequency
N = length(accelerometer_X);
t = (0:N-1) / fs;  % Time in seconds

% Plot the accelerometer - X signal in red
figure;

% Normalize the accelerometer signal for better visibility compared to the envelope
t_envelope = (0:length(envelope)-1) / fs;
plot(t_envelope, envelope, 'y');

% Overlay the envelope signal in yellow
hold on;
scale_factor = max(envelope) / max(accelerometer_X);
scaled_accelerometer_X = accelerometer_X * scale_factor;

plot(t, scaled_accelerometer_X, 'r');
title('Deltoid Accelerometer - X and Movement Signal');
xlabel('Time (s)');
ylabel('Accelerometer - X Value (scaled)');

scale_factorY = max(envelope) / max(accelerometer_Y);
scaled_accelerometer_Y = accelerometer_Y * scale_factorY;

plot(t,scaled_accelerometer_Y,'b')
% Calculate the time for the envelope signal based on its sampling frequency
legend('Envelope Signal', 'Accelerometer - X Signal','Accelerometer - Y Signal');
hold off;

% Answer to Question A:
% Down-sampling is performed after the envelope calculation to reduce the amount 
% of data to be processed. The envelope calculation often involves 
% the use of a transform or similar technique to extract the amplitude 
% components of the signal. This can result in a signal with a much higher frequency 
% compared to the original signal, especially if the EMG (electromyography) 
% was acquired at a high sampling frequency like 2000 Hz. 
% Down-sampling reduces the signal's sampling frequency 
% to reduce data complexity and simplify further analysis or processing without losing necssary information.
% 
% Answer to Question B:
% To determine when muscle activation commences in relation to movement,
% it is necessary to analyze motion data overlaid with the EMG envelope signal. 
% The onset of muscle activation may vary depending on the type of movement and 
% the muscles involved. Analyzing overlaid data will help identify the moment 
% when muscle activation begins in response to the movement. 
% This can be determined by observing points where the motion signal and 
% the EMG envelope signal shows significant variations or an increase in activity.




