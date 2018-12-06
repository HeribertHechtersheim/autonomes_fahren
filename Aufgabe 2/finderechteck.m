function [imagepoints] = finderechteck(I)
%fuer die Aufloesung 160x120
%findet koordinaten der Ecken des rechteckes im Bild
%IGr=rgb2gray(I);
%IG=imgaussfilt(IGr,5);
%I=max(I(:,:,1),0); %rot vorheben
%imshow([I(:,:,1) I(:,:,2); I(:,:,3) I(:,:,1)-0.5*I(:,:,2)-0.5*I(:,:,3)]);
I=I(:,:,1)-0.5*I(:,:,2)-0.5*I(:,:,3);
I = imbinarize(I,0.3);
%imshow(I);
x1=floor(size(I,2)/2);
y1=floor(size(I,1)/2);
iteration=1;
schrittgroesse=10;
%imshow(I)
%hold on;
finished=false;
[imagepoints]=rechteck(I,x1,y1);
if imagepoints(1)~=-1
    finished=true;
end

%spiralfoermiges durchlaufen zur quadratsuche
while(finished==false)
    
    for i=1:iteration
        x1=x1+schrittgroesse;
        [imagepoints]=rechteck(I,x1,y1);
        if imagepoints(1)~=-1
            finished=true;
            break;
        end
    end
    
    if finished~=true
        for i=1:iteration
            if (y1-schrittgroesse>1)
                y1=y1-schrittgroesse;
            else
                finished=true;
            end
            [imagepoints]=rechteck(I,x1,y1);
            if imagepoints(1)~=-1
                finished=true;
                
                break;
            end
        end
    end
    
    
    if finished~=true
        iteration=iteration+1;
        for i=1:iteration
            x1=x1-schrittgroesse;
            [imagepoints]=rechteck(I,x1,y1);
            if imagepoints(1)~=-1
                finished=true;
                
                break;
            end
        end
    end
    if finished~=true
        for i=1:iteration
            if (y1+schrittgroesse<size(I,1))
                y1=y1+schrittgroesse;
            else
                finished=true;
            end
            [imagepoints]=rechteck(I,x1,y1);
            if imagepoints(1)~=-1
                finished=true;
                
                break;
            end
        end
        
        iteration=iteration+1;
        
    end
end
end


function [imagepoints]=rechteck(BW,x1,y1)

Farbe=1;

seitenabstand=3;



x=x1;
y=y1;
while (BW(y,x)==Farbe)
    
    if y>2
        y=y-1;
    else
        break;
    end
end

b1=y;

x=x1;
y=y1;
while (BW(y,x)==Farbe)
    
    if y<size(BW,1)
        y=y+1;
    else
        break;
    end
end

b2=y;

ym=floor((b1+b2)/2);

x=x1;
y=ym;

while (BW(y,x)==Farbe)
    
    if x<size(BW,2)
        x=x+1;
    else
        break;
    end
end

xr=x-seitenabstand;

x=x1;
y=ym;


while (BW(y,x)==Farbe)
    
    if x>1
        x=x-1;
    else
        break;
    end
end

xl=x+seitenabstand;



x2=xl;
y2=ym;

x=x2;
y=y2;
while (BW(y,x)==Farbe)
    
    if y>2
        y=y-1;
    else
        break;
    end
end

b1=y;

x=x2;
y=y2;
while (BW(y,x)==Farbe)
    
    if y<size(BW,1)
        y=y+1;
    else
        break;
    end
end

b2=y;

xol=xl-seitenabstand;
xul=xl-seitenabstand;
yol=b1;
yul=b2;


x3=xr;
y3=ym;

x=x3;
y=y3;
while (BW(y,x)==Farbe)
    
    if y>2
        y=y-1;
    else
        break;
    end
end

b1=y;

x=x3;
y=y3;
while (BW(y,x)==Farbe)
    
    if y<size(BW,1)
        y=y+1;
    else
        break;
    end
end

b2=y;

xor=xr+seitenabstand;
xur=xr+seitenabstand;
yor=b1;
yur=b2;

l_links=yul-yol;
l_rechts=yur-yor;
l_mitte=xr-xl;

%sinnvolle quadratdimensionen?
if (l_links>1.3*l_rechts || l_rechts>1.3*l_links ||...
        l_links>1.3*l_mitte || l_mitte>1.3*l_links ...
        ||  max((ym-yol)/(ym-yor),(yul-ym)/(yur-ym))>1.3...
        ||l_mitte<5)
    %plot(x1,y1,'o');
    %plot(x1,y1,'+');
    %plot ([xr xr],[yor yur]);
    %plot ([xl xl],[yol yul]);
    %plot ([xl xr],[ym ym]);
    imagepoints=[-1 yol; xor yor;xul yul; xur yur];
else %sinvolles quadrat gefunden
    %plot(x1,y1,'+');
    imagepoints=[xol yol; xor yor;xul yul; xur yur];
end

end
