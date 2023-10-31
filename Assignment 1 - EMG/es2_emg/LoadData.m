load('ES2_emg.mat');
%plot di ogni segnale isolato sull'asse dei tempi
figure(1);
subplot(4,1,1);
plot(ES2_emg.time,ES2_emg.signals(:,1));
subplot(4,1,2);
plot(ES2_emg.time,ES2_emg.signals(:,2));
subplot(4,1,3);
plot(ES2_emg.time,ES2_emg.signals(:,3));
subplot(4,1,4);
plot(ES2_emg.time,ES2_emg.signals(:,4));

% Angolo di rotazione in gradi
angolo = 45;

% Converte l'angolo in radianti
angolo_rad = deg2rad(angolo);

% Matrice di rotazione 2D
R = [cos(angolo_rad), -sin(angolo_rad) 0; sin(angolo_rad), cos(angolo_rad) 0; 0 0 1];

