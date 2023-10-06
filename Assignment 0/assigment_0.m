% Assignment 0 of Biomedical Robotics

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 1: Load the datasets
load('data1.mat');
load('data2.mat');
load('data3.mat');

% Transpose the second and third dataset to have column vectors
data2 = data2';
data3 = data3'; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 2: Plot each dataset with appropriate labels
% Plot in the time domain
figure(1);

subplot(3, 1, 1);
plot(data1);
xlabel('Time (s)');
ylabel('Values');
title('EMG');

subplot(3, 1, 2);
plot(data2);
xlabel('Time (s)');
ylabel('Values');
title('Motion Data');

subplot(3, 1, 3);
plot(data3);
xlabel('Time (s)');
ylabel('Values');
title('EEG');

% Plot in the frequency domain
figure(2);

subplot(3, 1, 1);
Y1 = fft(data1);
fs1 = 2000; %Hz
frequencies1 = (0:(length(Y1)/2)-1)*fs1/length(Y1);
plot(frequencies1, abs(Y1(1:(length(Y1)/2))));
xlabel('Frequency');
ylabel('Amplitude');
title('EMG');

subplot(3, 1, 2);
Y2 = fft(data2);
fs2 = 166;
frequencies2 = (0:(length(Y2)/2)-1)*fs2/length(Y2);
plot(frequencies2, abs(Y2(1:(length(Y2)/2))));
xlabel('Frequency');
ylabel('Amplitude');
title('Motion Data');

subplot(3, 1, 3);
Y3 = fft(data3);
fs3 = 250;
frequencies3 = (0:length(Y3)-1)*fs3/length(Y3);
plot(frequencies3, abs(Y3));
xlabel('Frequency');
ylabel('Amplitude');
title('EEG');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

