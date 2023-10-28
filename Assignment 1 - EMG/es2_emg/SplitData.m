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
