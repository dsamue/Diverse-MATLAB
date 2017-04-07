function VideoDecoder(EncodedVideo, Codebook, height, width )
%% VideoDecoder
%Decodes the encoded videofile and saves as Show.avi

%% Create a videoobject to write to
writerObj = VideoWriter('Show.avi','Grayscale AVI');
open(writerObj);

%% Decode the frames

nFrames=size(EncodedVideo,1);  %Number of frames

for i = 1:nFrames 
    DecodeNR=i %Counter
    
    encodedFrame =  EncodedVideo{i};    
    
    decodedHuff = huffmanDecoder(encodedFrame, Codebook);
    decodedFrame = diffDecoder(decodedHuff,height,width);

    writeVideo(writerObj, decodedFrame); %Write encoded frame to videofile
end

%% Close the Video File
close(writerObj);
end

