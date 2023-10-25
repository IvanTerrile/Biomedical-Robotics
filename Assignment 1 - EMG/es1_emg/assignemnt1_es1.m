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

% Rectify the filtered EMG signal, meaning consider only the positive values of the output
rectifiedSignal = abs(filteredEMG);

%Creating a lowpass filter with a frequency of 4hz to compute the envelope 
freq_low=4;
freqCutOff=freq_low/nyquist;
b_low=fir1(filterOrder,freqCutOff,'low');
envelope = filtfilt(b_low,1,rectifiedSignal);

% Set the maximum frequency (f_max) and calculate the new sampling frequency (newfs)
div_factor = 2;
f_max = 450;
new_fs = fs / div_factor ;

% Check if newfs > 2*fmax, Nyquist theorem is satisfied, 
% so you can use new_fs for downsampling the envelope
if new_fs > 2*f_max
    downsampledEnvelope = downsample(envelope, div_factor);
end

matrix_accelerometer = Es1_emg.matrix(:, 2:4);
norm_acceleration = sqrt((matrix_accelerometer(:,1).^2)+(matrix_accelerometer(:,2).^2)+(matrix_accelerometer(:,3).^2));
% Initialize a vector of zeros for norms

%sqrt(x.^2+y.^2+z.^2)
%normalizzare inviluppo dividere ciascun valore dell'inviluppo per il max
%dell'inviluppo
normalized_envelope = envelope/max(envelope) ;

% Normalize the accelerometer signal for better visibility compared to the envelope
t_envelope = (0:length(envelope)-1) / fs;

% Create a figure
figure;

% First subplot (3 rows, 1 column, first plot)
subplot(3, 1, 1);
plot(t_signal, Es1_emg.matrix(:, 1), 'b', t_signal, filteredEMG, 'r');
xlabel('Time (ms)');
ylabel('EMG Signal (mV)');
title('Original vs. Filtered EMG Signal');
legend('Unfiltered', 'Filtered');

% Second subplot (3 rows, 1 column, second plot)
subplot(3, 1, 2);
plot(t_signal, rectifiedSignal, t_signal, envelope, 'r');
legend('Rectified Signal', 'Envelope');
title('Rectified Signal and Envelope');
xlabel('Time(ms)');
ylabel('Amplitude');

% Third subplot (3 rows, 1 column, third plot)
subplot(3, 1, 3);
plot(t_signal,  norm_acceleration-1.05, 'r', t_envelope, normalized_envelope, 'b');
legend( 'Norm of acceleration','Envelope');
xlabel('Time (ms)');
ylabel('Signal (V)');
title('Movement Signal and Envelope');

%l'anticipo si vede di 100-200ms envelope parte prima
% Answer to Question A:
% Down-sampling is performed after the envelope calculation to reduce the amount 
% of data to be processed. The envelope calculation often involves 
% the use of a transform or similar technique to extract the amplitude 
% components of the signal. This can result in a signal with a much higher frequency 
% compared to the original signal, especially if the EMG (electromyography) 
% was acquired at a high sampling frequency like 2000 Hz. 
% Down-sampling reduces the signal's sampling frequency 
% to reduce data complexity and simplify further analysis or processing without losing necessary information.
% 
% Answer to Question B:
% To determine when muscle activation commences in relation to movement,
% it is necessary to analyze motion data overlaid with the EMG envelope signal. 
% The onset of muscle activation may vary depending on the type of movement and 
% the muscles involved. Analyzing overlaid data will help identify the moment 
% when muscle activation begins in response to the movement. 
% This can be determined by observing points where the motion signal and 
% the EMG envelope signal shows significant variations or an increase in activity.
