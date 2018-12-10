%% Lenkwinkel(Motor Angle) stationär

motorangle=[-300 -200 -100 0 100 200 300];     %Regler in Simulink
Radwinkel=[-25 -20 -12 0 7.0 14.2 20]./180*pi;  %gemessen (rechtes Vorderrad)

figure
plot(motorangle,Radwinkel/pi*180);
xlabel('Motor Angle')
ylabel('Radwinkel in Grad')


%Radwinkel=(Radwinkel-flipud(Radwinkel')')*0.5;
%Durchschnitt des Innen- und Außenrades für Einspurmodell (ungefähr)
Radwinkel=[-22.5 -17.1 -9.5 0 9.5 17.1 22.5]./180*pi;   
figure
plot(motorangle,Radwinkel/pi*180);
xlabel('Motor Angle')
ylabel('Radwinkel des Einspurmodelles in Grad')
