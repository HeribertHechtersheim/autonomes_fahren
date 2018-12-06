function [u,v] = WeltzuPixelkoordinaten(IntrinsicMatrix,KameraPosition,xrot,yrot,zrot,Weltkoordinaten)

RX=[1 0 0; 0 cos(xrot) -sin(xrot); 0 sin(xrot) cos(xrot)];
RY=[cos(yrot) 0 sin(yrot);0 1 0;-sin(yrot) 0 cos(yrot)];
RZ=[cos(zrot) -sin(zrot) 0;sin(zrot) cos(zrot) 0; 0 0 1;];

Kamerarotation=RX*RY*RZ;

Distanzvektor=Weltkoordinaten-KameraPosition;
Distanzvektor=Kamerarotation*Distanzvektor;


p=IntrinsicMatrix'*Distanzvektor;

u=p(1)/p(3);
v=p(2)/p(3);
end

