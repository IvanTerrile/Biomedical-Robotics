% Load the data from 'ES2_emg.mat'
load('ES2_emg.mat');

% Plot each isolated signal on the time axis
figure(1);

% Subplot 1 for Biceps Right
subplot(4,1,1);
plot(ES2_emg.time, ES2_emg.signals(:,1));
title('Biceps Right');

% Subplot 2 for Biceps Left
subplot(4,1,2);
plot(ES2_emg.time, ES2_emg.signals(:,2));
title('Biceps Left');

% Subplot 3 for Trapezius Right     
subplot(4,1,3);
plot(ES2_emg.time, ES2_emg.signals(:,3));
title('Trapezius Right')

% Subplot 4 for Trapezius Left
subplot(4,1,4);
plot(ES2_emg.time, ES2_emg.signals(:,4));
title('Trapezius Left')

% Rotation angle in degrees
angle = 45;

% Convert the angle to radians
angle_rad = deg2rad(angle);

% 2D Rotation matrix
R = [cos(angle_rad), -sin(angle_rad),  0; 
     sin(angle_rad),  cos(angle_rad),  0; 
                  0,               0,  1];