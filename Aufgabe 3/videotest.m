%% video 1
load('vout.mat')
for i=1:31
   I=vout(:,:,i)';
   I=imresize(I,3280/800);
   B=birdeyetransform(I); 
subplot(1,2,1), imshow(I)
subplot(1,2,2), imshow(B)
   
  pause(0.01);
end
%% video 2
load('vout1.mat')
for i=10:80
   I=vout(:,:,i)';
   I=imresize(I,3280/320);
   B=birdeyetransform(I); 
subplot(1,2,1), imshow(I)
subplot(1,2,2), imshow(B)
   
  pause(0.01);
end


