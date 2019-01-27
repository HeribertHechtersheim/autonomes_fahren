function [map, overlapScore] = addToMap(map,I,x,y,angle)
%addToMap adds timage I to the map with center at x,y
%   angle in radians
[n,m]=size(map);
center_map_x=floor(m/2);
center_map_y=floor(n/2);
I=imrotate(I,angle*180/pi-90);
[a,b]=size(I);
center_I_x=floor(m/2);
center_I_y=floor(n/2);
overlapScore=0;
overlapCount=0;
for i=1:a
    for j=1:b
        if I(i,j)~=0
            X= j+floor(x)+center_map_x-center_I_x;
            Y= i+floor(y)+center_map_y-center_I_y;
            if map(Y,X)~=0
                overlapScore=overlapScore+(double(map(Y,X))-double(I(i,j)))^2;
                overlapCount=overlapCount+1;
            else
                map(Y,X)=I(i,j);
            end
        end
    end
end

overlapScore=overlapScore/overlapCount;

end

