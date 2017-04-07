function YUVframe = frameRGB2YUV( aRGBframe )
%% RGB2YUV Frame
%Takes a RGB frame and converts to YUV
%%

%Make an empty matrix in same size as input 
frameheight=size(aRGBframe,1);
framewidth=size(aRGBframe,2);
YUVframe=zeros(frameheight,framewidth,3);

%YUV-Matrix
mtx=[0.2126 0.7152 0.0722; -0.09991 -0.33609 0.436; 0.615 -0.55861 -0.05639];

%For each pixel..
for i=1:frameheight
    for j=1:framewidth
        %Pick out rgb-values
        r=aRGBframe(i,j,1);
        g=aRGBframe(i,j,2);
        b=aRGBframe(i,j,3);
        
        %Convert to YUV
        YUV=mtx*double([r g b]'); 
        
        %Put new values in YUV-matrix
        YUVframe(i,j,1) = YUV(1);
        YUVframe(i,j,2) = YUV(2);
        YUVframe(i,j,3) = YUV(3);
    end
end

%Convert YUVframe to uint8
YUVframe=uint8(single(YUVframe));  

end


