clc
Weltkoordinaten1=[-5 ;5 ; 10];
Weltkoordinaten2=[5 ;5 ; 10];
Weltkoordinaten3=[5 ;-5 ;10];
Weltkoordinaten4=[-5 ;-5 ;10];
Weltkoordinaten5=[-5 ;5 ; 20];
Weltkoordinaten6=[5 ;5 ; 20];
Weltkoordinaten7=[5 ;-5 ;20];
Weltkoordinaten8=[-5 ;-5 ;20];

Kameraposition=[0; 0; 0];
xrot=0/180*pi;
yrot=0;
zrot=0;

[u(1),v(1)]=WeltzuPixelkoordinaten(picam_params.IntrinsicMatrix,Kameraposition,...
    xrot,yrot,zrot,Weltkoordinaten1);

[u(2),v(2)]=WeltzuPixelkoordinaten(picam_params.IntrinsicMatrix,Kameraposition,...
    xrot,yrot,zrot,Weltkoordinaten2);


[u(3),v(3)]=WeltzuPixelkoordinaten(picam_params.IntrinsicMatrix,Kameraposition,...
    xrot,yrot,zrot,Weltkoordinaten3);


[u(4),v(4)]=WeltzuPixelkoordinaten(picam_params.IntrinsicMatrix,Kameraposition,...
    xrot,yrot,zrot,Weltkoordinaten4);

[u(5),v(5)]=WeltzuPixelkoordinaten(picam_params.IntrinsicMatrix,Kameraposition,...
    xrot,yrot,zrot,Weltkoordinaten5);

[u(6),v(6)]=WeltzuPixelkoordinaten(picam_params.IntrinsicMatrix,Kameraposition,...
    xrot,yrot,zrot,Weltkoordinaten6);

[u(7),v(7)]=WeltzuPixelkoordinaten(picam_params.IntrinsicMatrix,Kameraposition,...
    xrot,yrot,zrot,Weltkoordinaten7);

[u(8),v(8)]=WeltzuPixelkoordinaten(picam_params.IntrinsicMatrix,Kameraposition,...
    xrot,yrot,zrot,Weltkoordinaten8);


u(9)=u(5);
v(9)=v(5);
plot([u(1:4) u(1) u(5:9) ],[v(1:4) v(1) v(5:9)],'-+');
hold on;
plot([u(2) u(6)],[v(2),v(6)])
plot([u(3) u(7)],[v(3),v(7)])
plot([u(4) u(8)],[v(4),v(8)])

axis([1 3280 1 2464])


PixelzuWeltkoordinaten(u(1),v(1),u(2),v(2))
