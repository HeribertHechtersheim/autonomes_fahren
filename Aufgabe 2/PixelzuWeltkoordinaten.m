function [Weltkoordinaten] = PixelzuWeltkoordinaten(u1,v1,u2,v2)

intrinsicMatrix= 1.0e+03 *...
    [2.5966         0    1.6534;
    0    2.6037    1.2445;
    0         0    0.0010];


a=intrinsicMatrix(1,1);
b=intrinsicMatrix(1,3);
c=intrinsicMatrix(3,3);
d=intrinsicMatrix(2,2);
e=intrinsicMatrix(2,3);

A=[a 0 b-c*u1 0 0 0;...
    0 d e-c*v1 0 0 0;...
    -1 0 0 1 0 0;...
    0 0 0 a 0 b-c*u2;...
    0 0 0 0 d e-c*v2;...
    0 0 -1 0 0 1];

Weltabstand=[0;0;10;0;0;0];

Weltkoordinaten=A\Weltabstand;

end

