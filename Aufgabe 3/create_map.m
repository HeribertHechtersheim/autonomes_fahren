load('vout1.mat');
load('steeringdata.mat');
startframe=12; 
map=uint8(zeros(1000,2000));
x=zeros(size(steering.signals.values,1),1);
y=zeros(size(steering.signals.values,1),1);
angle=zeros(size(steering.signals.values,1),1);
error=zeros(size(steering.signals.values,1),1);
coefficients=zeros(2,3,size(steering.signals.values,1),1);
I= vout(:,:,startframe)';
B=birdeyetransform(I);

speed=15;
centeroffset_y= size(B,1); % just a guess, pixel distance to where the camera woud be
%start position/orientation
x(startframe)=10;
y(startframe)=200;
angle(startframe)=0;
map=addToMap(map,B,floor(x(startframe)+centeroffset_y*cos(angle(startframe))),...
    floor(y(startframe)-centeroffset_y*sin(angle(startframe))),angle(startframe));



for i=startframe+1:size(vout,3)
    
    %simple kalman filter to predict approximate current position 
    x(i)=x(i-1)+cos(angle(i-1))*speed;
    y(i)=y(i-1)-sin(angle(i-1))*speed;
    %end kalman
    
    
    I= vout(:,:,i)';
    B=birdeyetransform(I);
    
    overlapHighscore=inf;
    testvalues_angle=8;
    testvalues_position=4;
    position_change=3;
    angle_change=2; %in degree
    for a=-testvalues_position:testvalues_position
        for b=-testvalues_position:testvalues_position
            for c=-testvalues_angle:testvalues_angle
                test_x=x(i)+a*position_change;
                test_y=y(i)+b*position_change;
                test_angle=angle(i)+(c/180*pi*angle_change);
                [mapt, overlapScore]=addToMap(map,B,floor(test_x+centeroffset_y*cos(test_angle)),...
                        floor(test_y-centeroffset_y*sin(test_angle)),test_angle);
                if overlapScore<overlapHighscore && ~isnan(overlapScore)
                    overlapHighscore=overlapScore;
                    mapHigh=mapt;
                    best_x_coarse=test_x;
                    best_y_coarse=test_y;
                    best_angle_coarse=test_angle;
                    best_a=a;
                    best_b=b;
                    best_c=c;
                end
                
            end
        end
    end
    
    
    if best_c==-testvalues_angle
        a=best_a;
        b=best_b;
        for c=-testvalues_angle:-1:-3*testvalues_angle
            test_x=x(i)+a*position_change;
            test_y=y(i)+b*position_change;
            test_angle=angle(i)+(c/180*pi*angle_change);
            [mapt, overlapScore]=addToMap(map,B,floor(test_x+centeroffset_y*cos(test_angle)),...
                        floor(test_y-centeroffset_y*sin(test_angle)),test_angle);
            if overlapScore<overlapHighscore && ~isnan(overlapScore)
                overlapHighscore=overlapScore;
                mapHigh=mapt;
                best_angle_coarse=test_angle;
                best_c=c;
            end

        end

    end
    
    
    if best_c==testvalues_angle
        a=best_a;
        b=best_b;
        for c=testvalues_angle:3*testvalues_angle
            test_x=x(i)+a*position_change;
            test_y=y(i)+b*position_change;
            test_angle=angle(i)+(c/180*pi*angle_change);
            [mapt, overlapScore]=addToMap(map,B,floor(test_x+centeroffset_y*cos(test_angle)),...
                        floor(test_y-centeroffset_y*sin(test_angle)),test_angle);
            if overlapScore<overlapHighscore && ~isnan(overlapScore)
                overlapHighscore=overlapScore;
                mapHigh=mapt;
                best_angle_coarse=test_angle;
                best_c=c;
            end

        end

    end
    
    
    
    if best_a==testvalues_position
        c=best_angle_coarse;
        b=best_b;
        for a=testvalues_position:testvalues_position*2
            test_x=x(i)+a*position_change;
            test_y=y(i)+b*position_change;
            test_angle=angle(i)+(c/180*pi*angle_change);
            [mapt, overlapScore]=addToMap(map,B,floor(test_x+centeroffset_y*cos(test_angle)),...
                        floor(test_y-centeroffset_y*sin(test_angle)),test_angle);
            if overlapScore<overlapHighscore && ~isnan(overlapScore)
                overlapHighscore=overlapScore;
                mapHigh=mapt;
                best_x_coarse=test_x;
                best_a=a;
            end

        end

    end
    
    
    if best_a==-testvalues_position
        c=best_angle_coarse;
        b=best_b;
        for a=-testvalues_position:-1:-testvalues_position*2
            test_x=x(i)+a*position_change;
            test_y=y(i)+b*position_change;
            test_angle=angle(i)+(c/180*pi*angle_change);
            [mapt, overlapScore]=addToMap(map,B,floor(test_x+centeroffset_y*cos(test_angle)),...
                        floor(test_y-centeroffset_y*sin(test_angle)),test_angle);
            if overlapScore<overlapHighscore && ~isnan(overlapScore)
                overlapHighscore=overlapScore;
                mapHigh=mapt;
                best_x_coarse=test_x;
                best_a=a;
            end

        end

    end
    
    
    if best_b==testvalues_position
        c=best_angle_coarse;
        a=best_a;
        for b=testvalues_position:testvalues_position*2
            test_x=x(i)+a*position_change;
            test_y=y(i)+b*position_change;
            test_angle=angle(i)+(c/180*pi*angle_change);
            [mapt, overlapScore]=addToMap(map,B,floor(test_x+centeroffset_y*cos(test_angle)),...
                        floor(test_y-centeroffset_y*sin(test_angle)),test_angle);
            if overlapScore<overlapHighscore && ~isnan(overlapScore)
                overlapHighscore=overlapScore;
                mapHigh=mapt;
                best_y_coarse=test_y;
                best_b=b;
            end

        end

    end
    
    
    if best_b==-testvalues_position
        c=best_angle_coarse;
        a=best_a;
        for b=-testvalues_position:-1:-testvalues_position*2
            test_x=x(i)+a*position_change;
            test_y=y(i)+b*position_change;
            test_angle=angle(i)+(c/180*pi*angle_change);
            [mapt, overlapScore]=addToMap(map,B,floor(test_x+centeroffset_y*cos(test_angle)),...
                        floor(test_y-centeroffset_y*sin(test_angle)),test_angle);
            if overlapScore<overlapHighscore && ~isnan(overlapScore)
                overlapHighscore=overlapScore;
                mapHigh=mapt;
                best_y_coarse=test_y;
                best_b=b;
            end

        end

    end
    
    
    %finer grid
    testvalues_angle=4;
    testvalues_position=3;
    position_change=position_change/testvalues_position;
    angle_change=angle_change/testvalues_angle; 
    for a=-testvalues_position:testvalues_position
        for b=-testvalues_position:testvalues_position
            for c=-testvalues_angle:testvalues_angle
                test_x=best_x_coarse+a*position_change;
                test_y=best_y_coarse+b*position_change;
                test_angle=best_angle_coarse+(c/180*pi*angle_change);
                [mapt, overlapScore]=addToMap(map,B,floor(test_x+centeroffset_y*cos(test_angle)),...
                        floor(test_y-centeroffset_y*sin(test_angle)),test_angle);
                if overlapScore<overlapHighscore && ~isnan(overlapScore)
                    overlapHighscore=overlapScore;
                    mapHigh=mapt;
                    best_x=test_x;
                    best_y=test_y;
                    best_angle=test_angle;
                    best_a_fine=a;
                    best_b_fine=b;
                    best_c_fine=c;
                end
                
            end
        end
    end
    
    
    
    %update position
    x(i)=best_x;
    y(i)=best_y;
    angle(i)=best_angle_coarse;
    error(i)=overlapHighscore;
    overlapHighscore
    [best_a best_b best_c; best_a_fine best_b_fine best_c_fine]
    coefficients(:,:,i)=[best_a best_b best_c; best_a_fine best_b_fine best_c_fine];
    
    map=mapHigh;
    
    subplot(2,3,1), plot(x(startframe:1:i),-y(startframe:1:i));
    axis(1000*[0 1.0 -1.5 0]);
    subplot(2,3,4), imshow(I);
    subplot(2,3,5), imshow(B);
    subplot(2,3,3), imshow(map);title('"Satellitenbild"')
    subplot(2,3,6), imshow(imbinarize(map,0.8));
    subplot(2,3,2), plot(error(startframe+1:1:i)); title('error')
    pause(0.001);
end

