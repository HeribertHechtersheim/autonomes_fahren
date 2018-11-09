%% v(Motor Speed) gerade Strecke

motorspeed=[350 400 500 1000 1500 2000 2000 2500 3000];  %Regler in Simulink
Strecke=1;
t=[2.639 2.381  1.773 1.013 0.792 0.642 0.676 0.638 0.574 ];

v=Strecke./t;

figure
plot(motorspeed,v);
xlabel('Motor Speed')
ylabel('v in m/s')

%% v(Motor Speed) gerade Strecke

motorspeed=[350 400 500 1000 1500 2000 2500 3000];  %Regler in Simulink
Strecke=1;
t=[2.639 2.381  1.778 1.013 0.792 0.684 0.64 0.598 ];

v=Strecke./t;

figure
plot(motorspeed,v,'*-');
xlabel('Motor Speed')
ylabel('v in m/s')


%% Lenkwinkel(Motor Angle) stationär

motorangle=[-300 -100 100 300];     %Regler in Simulink
Radwinkel=[-45 -10 10 45]./180*pi;  %gemessen

figure
plot(motorangle,Radwinkel/pi*180);
xlabel('Motor Angle')
ylabel('Radwinkel in Grad')

%% v(Motor Speed, Motor Angle) Kreisfahrt

motorspeed=[ 400 500 750 1000];
motorangle=[-300 -100 100 300];
Radwinkel=[-40 -9 10 41]./180*pi;
R=[3 3 3 3];
t=[ 45 40 50 35];

Strecke=2*pi.*R;
v=Strecke./t;

figure
subplot(2,1,1);
plot(motorspeed,v);
xlabel('Motor Speed')
ylabel('v in m/s')

subplot(2,1,2);
plot(motorangle,Radwinkel/pi*180);
xlabel('Motor Angle')
ylabel('Radwinkel in Grad')



%% Bestimmung von k_sh durch Messen von Beta

m=1;
l_v=0.1;
l_h=0.1;
R=[1 2];                           %Radius des Kreises
t=[10 20];                         %Dauer der Kreisfahrt
Runden=[1 1];

Beta=[ 3 2]./180*pi;

Kreisumfang=2*pi*R;
v=Kreisumfang.*Runden./t;
l=l_v+l_h;

k_sh=(l_v.*m.*v.^2)./(l.*(l_h-R.*Beta))
k_sh_mittel=mean(k_sh)

%% Bestimmung von k_sv durch Messen von delta_v

delta_v=[28 15]/180*pi;

k_sv=l_h./(l^2*(R.*delta_v-l)./(m*l.*v.^2)+l_v/k_sh_mittel)
k_sv_mittel=mean(k_sv)


unter_ueber_steuern=k_sh_mittel*l_h-k_sv_mittel*l_v

%% k_sh(Beta) 

l_v=0.1;
l_h=0.1;
R=[1];                          
t=[10];                         
Runden=[1];

Beta=[0:0.1:5]./180*pi;

Kreisumfang=2*pi*R;
v=Kreisumfang.*Runden./t;
l=l_v+l_h;

k_sh=l_v.*m.*v.^2./(l.*(l_h-R.*Beta));
figure
plot(Beta./pi*180,k_sh);
xlabel('Schwimmwinkel Beta in Grad')
ylabel('k_{sh}')

%% k_sv(delta_v) 

l_v=0.1;
l_h=0.1;
R=[1];                          
t=[10];                         
Runden=[1];

delta_v=[0:0.1:45]./180*pi;

Kreisumfang=2*pi*R;
v=Kreisumfang.*Runden./t;
l=l_v+l_h;

figure
k_sv=l_h./(l^2*(R.*delta_v-l)/(m*l.*v.^2)+l_v/k_sh_mittel);
plot(delta_v./pi*180,k_sv);
xlabel('delta_v')
ylabel('k_{sv}')