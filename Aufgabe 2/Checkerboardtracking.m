%%
delete(cam)

%% setup
cam=webcam(1);
%% 
squareSize=26.5; % seitenlaenge in millimeter

a=1;    %jeden a-ten Pixel betrachten um Aufloesung zu verringern
squareSize=squareSize/a;

%Visualisierungen
erkanntes_Checkerboard=1;
Kameraposition=0;

%% checkerboard tracking
Abstand=zeros(2,1);
tic
while(1)
I=snapshot(cam);
%I=rgb2gray(I);

I=I(1:a:size(I,1),1:a:size(I,2),:);

%finde checkerboard
[imagePoints, boardSize] = detectCheckerboardPoints(I);
if(boardSize<=0)
    disp('Kein Checkerboard gefunden')
    continue;
end


%Berechne Kameraposition
worldPoints = generateCheckerboardPoints(boardSize,squareSize);
[rotationMatrix, translationVector] = extrinsics(imagePoints,worldPoints,cameraParams);
[Orientierung, Kameraposition] = extrinsicsToCameraPose(rotationMatrix, translationVector);

%Visualisierungen
if (Kameraposition==1)
    %Visualisiere Kameraposition
    figure
    plotCamera('Location',Kameraposition,'Orientation',Orientierung,'Size',20);
    hold on
    pcshow([worldPoints,zeros(size(worldPoints,1),1)],'VerticalAxisDir','down','MarkerSize',40);
end
if (erkanntes_Checkerboard==1)
    %Zeige erkanntes Checkerboard
    J = insertText(I, imagePoints, 1:size(imagePoints, 1));
    J = insertMarker(J, imagePoints, 'o', 'Color', 'red', 'Size', 5);
    imshow(J);
    title(sprintf('Detected a %d x %d Checkerboard', boardSize));
end

%Berechne Abstand zum Mittelpunkt des Checkerboards
y=squareSize*(boardSize(1)-1)/2;
x=squareSize*(boardSize(2)-1)/2;
z=0;
Checkerpostion=[x y z];
Differenz=(Checkerpostion-Kameraposition)/10; %Abstand in cm

Abstand(2)=Abstand(1);
Abstand(1)=norm(Differenz);
Differenzaenderung=(Abstand(1)-Abstand(2))/toc;
tic
%2. Komponente ist rechts links, 1. oben unten, 3. vorne hinten (falls hochkant, weiß oben)

Lenkeinschlag=Differenz(2)/Abstand(1);   %Differenz(1) für horizontal
if (Lenkeinschlag>=0)
    Lenken=['Rechts lenken mit ' num2str(Lenkeinschlag)];
else
    Lenken=['links lenken mit ' num2str(-Lenkeinschlag)];
end

if (Abstand(1)>50)
    Beschleunigung=['Beschleunigen' ];
else
    Beschleunigung=['Bremsen' ];
end

disp([Beschleunigung ', ' Lenken])

end
