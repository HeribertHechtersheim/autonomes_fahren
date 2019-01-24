%% 
load('steering3.mat');
alpha=2.8;
%%
load('steering2.mat');
alpha=2.8;
%%
load('steeringdata.mat');
alpha=2.1;
%%
angle=0;
speed=1;
x=zeros(size(steering.signals.values,1),1);
y=zeros(size(steering.signals.values,1),1);
for i=1:floor(size(steering.signals.values,1))
    angle=angle-pi/180*alpha*(steering.signals.values(i));
   x(i+1)=x(i)+cos(angle)*speed;
   y(i+1)=y(i)+sin(angle)*speed;
end
plot(x,y);
axis(20*[-10 10 -10 10])
% Der Plot von 2 und 3 ist ziemlich genau, das Auto ist von der Strecke abgekommen