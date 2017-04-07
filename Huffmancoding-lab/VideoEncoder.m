function [encodedVideo,vidHeight,vidWidth]=VideoEncoder( filePath, nframes, Codebook )
%This funciton encodes the video via diff and huffman codeing

%% Open Video Object
vidObj = VideoReader(filePath);

%% Creating datastructure for storage
encodedVideo=cell(nframes,1);  %One cell for each frame

%% Extracting frames

for i = 1:nframes % Number of frames
    
    EncodeNR = i; %Counter
    frame =  read(vidObj, i);
    frame=imresize(frame, 0.1);   %resizeing

    bwFrame = frame(:,:,1)/3+frame(:,:,2)/3+frame(:,:,3)/3;  
    % Make a quick grayscale frame

     encodedFrame = diffEncoder(bwFrame);                  %Diff encode
     encodedHuff = huffmanEncoder(encodedFrame, Codebook); %Huff encode
     
     encodedVideo{i}=encodedHuff;          %Store decoded frame nr i
   
end
vidHeight=size(bwFrame,1);  %Output data for decoder
vidWidth=size(bwFrame,2);
end

