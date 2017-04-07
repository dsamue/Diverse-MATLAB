function frameRGB = frameYUV2RGB( frameYUV )
%% YUV2RGBframe
% Takes a YUV frame and converts to RGB
%%

%Dimensions and empty frame
frameheight=size(frameYUV,1);
framewidth=size(frameYUV,2);
frameRGB=zeros(frameheight,framewidth,3);

%U&V mtx
compU = frameYUV(:,:,2);
compV = frameYUV(:,:,3);

%Empty mtx
frameU=zeros(frameheight,framewidth);
frameV=zeros(frameheight,framewidth);

%Creates a new matrix from each 2X2 block 
%"lower" resolution than uncompressed
for i=1:2:frameheight
    for j=1:2:framewidth
        
        frameU(i,j) = compU(i,j);
        frameU(i+1,j) = compU(i,j);
        frameU(i,j+1) = compU(i,j);
        frameU(i+1,j+1) = compU(i,j);
        
        frameV(i,j) = compV(i,j);
        frameV(i+1,j) = compV(i,j);
        frameV(i,j+1) = compV(i,j);
        frameV(i+1,j+1) = compV(i,j);
    end
end

%mtx for YUV2RGB
mtx=[1 0 1.28033; 1 -0.21482 -0.38059; 1 2.12798 0];

%for each pixel..
for i=1:frameheight
    for j=1:framewidth
        %picks out the YUV values
        r=frameYUV(i,j,1);
        g=frameU(i,j);
        b=frameV(i,j);
        
        %Converts to RGB
        YUV=mtx*double([r g b]'); 
        
        %and puts back together
        frameRGB(i,j,1) = YUV(1);
        frameRGB(i,j,2) = YUV(2);
        frameRGB(i,j,3) = YUV(3);
    end
end

%Converts to uint8
frameRGB=uint8(single(round(frameRGB)));

end