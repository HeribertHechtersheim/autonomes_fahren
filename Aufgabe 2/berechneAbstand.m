function [Abstand_x,Abstand_z,gefunden] = berechneAbstand(I)


imagepoints=finderechteck(I);
imagepoints=imagepoints*3280/160;%skalieren auf Aufloesung

if (imagepoints(1,1)<0)
    Abstand_x=0;   
    Abstand_z=-1;
    gefunden=false;
   return;
end

u1=imagepoints(1,1);
v1=imagepoints(1,2);
u2=imagepoints(2,1);
v2=imagepoints(2,2);

b=PixelzuWeltkoordinaten(u1,v1,u2,v2);

Abstandsvektor=(b(1:3)+b(4:6))./2;
Abstand_z=Abstandsvektor(3);
Abstand_x=Abstandsvektor(1);
gefunden=true;


end


