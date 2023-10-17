load('ES1_emg.mat');
%asse y mV noi abbiamo questi dati asse x ms
% Definisci le frequenze di taglio
lowFreq = 30; % Frequenza di taglio inferiore
highFreq = 450; % Frequenza di taglio superiore

% Calcola la durata del filtro in campioni
fs = 2000; % Frequenza di campionamento
nyquist = fs / 2;
lowCutoff = lowFreq / nyquist;
highCutoff = highFreq / nyquist;
filterOrder = 100; % Ordine del filtro

% Creazione del filtro FIR
b = fir1(filterOrder, [lowCutoff, highCutoff]);

% Applica il filtro al segnale EMG
filteredEMG = filtfilt(b, 1, Es1_emg.matrix(:,1));

% Plot del segnale EMG originale (non filtrato) in blu
figure;
plot((0:size(Es1_emg.matrix, 1) - 1) / fs * 1000, Es1_emg.matrix(:, 1), 'b');
hold on;

% Plot del segnale EMG filtrato in rosso
plot((0:size(filteredEMG, 1) - 1) / fs * 1000, filteredEMG, 'r');

% Aggiungi etichette e titolo
xlabel('Tempo (ms)');
ylabel('Segnale EMG (mV)');
title('Segnale EMG Originale vs Filtrato');
legend('Non Filtrato', 'Filtrato');

hold off;

