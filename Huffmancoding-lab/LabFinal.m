%% Final lab report  - Grupp 5
%Sanna Marklund, Alexander Johansson, David Samuelsson
clear all; close all; clc

%% 2.Show random RGB, Y-cahnnel and converted RGB

%% Define the path
file  = 'testABCD.mp4'; % the location your video is stored 

%% Read and generate a move to display
% vidObj = VideoReader(file); % obj generation 
% nFrames = vidObj.NumberOfFrames;
% vidHeight = vidObj.Height;
% vidWidth = vidObj.Width;
% 
% % Preallocate movie structure.
% mov(1:nFrames) = ...
%     struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
%            'colormap', []);
% 
% % Read one frame at a time.
% for k = 1 : nFrames
%     mov(k).cdata = read(vidObj, k);
% end
% 
% % % Size a figure based on the video's width and height.
% % hf = figure;
% % set(hf, 'position', [150 150 vidWidth vidHeight])
% 
% % select a random frame from the video
% aRGBFrame =  mov(randi([1,100],1,1)).cdata ; 


%% If you dont want to do the videoread part above..                            Allts? bara f?r att spara tid f?r egen del
%Run the script with videoread once to save a random pictrue to file:
%imwrite(aRGBFrame, 'videoframe.jpg');  
%and than:
aRGBFrame=imread('videoframe.jpg');


%% Call RGB to YUV functon 
%This fuctions converts a RGB frame to a compressed YUV frame
YUVframe = frameRGB2YUV(aRGBFrame);  

%Extract Y channel
bwImg=YUVframe(:,:,1);    %Y (BW)

%% Convert back to RGB

newRGB=frameYUV2RGB(YUVframe);

%% Show images 

figure('Name','Original' ),
imshow(aRGBFrame);

figure('Name','Y-Channel' ),
imshow(bwImg);

figure('Name','RGB from YUV' ),
imshow(newRGB);

%% Create Huffman Codebook
% Our code..
newbwImg=imresize(bwImg,0.1);
huffCodebook=huffmanCodebook(newbwImg);

%% 3. Convert the video to .avi and show the processing time
                                                                               
% Differential Encode
encodedImg = diffEncoder(bwImg);

% Make Codebook for diff-values
p = histc(encodedImg(:),-255:255);               
p = abs(p/(numel(encodedImg)));             %Probability vector

symbols = -255:255;                         %Symbol vector

set(0,'RecursionLimit', 550)                %Changes the limit from 500
[diffCodebook,avglen] = huffmandict(symbols,p); %Create Codebook 

tic   % Start time for video conversion

% Encode the video
videofile  = 'testABCD.mp4';
[EncodedVideo,vidHeight,vidWidth]=VideoEncoder(videofile, 5, diffCodebook);
%2nd parameter is number of frames from video
%EncodedVideo is now a number_of_framesx1 cell array 

% Decode the video
VideoDecoder(EncodedVideo,diffCodebook,vidHeight,vidWidth);
%Decode and save as show.avi

toc    % End time for video conversion
                                                                                                                                                
                                                                                
%% 4. Show the histogram for the frame used for the 0-255 Huffman Codebook         
figure('Name','Distribution for Huffman values'),
imhist(bwImg)                    %Shows distribution


%% 5. Prove that the Differential decoder is correct                               Switchade plats p? 5&6 f?r att sen kunna k?ra med diff-bilden vid huffman encoding. Blir lite omst?ndigt annars eftersom vi har ?ndrat lite fr?n g?ng till g?ng

%encode
diffEncodedImg=diffEncoder(bwImg);

%decode
diffDecodedImg=diffDecoder(diffEncodedImg, 720, 1280);

% Validate that data is the same after en/de-codeing
status = isequal(bwImg, diffDecodedImg);
if status == 1
    CodingOK='Yes'
end
if status == 0
    CodingOK='No'
end

%% 6. Prove that the Huffman decoder is correct

%encode
huffEncodedImg=huffmanEncoder(diffEncodedImg(1:1000), diffCodebook);           % Kollar bara med f?rsta 1000 elementen i diffvectorn. Blir segt annars. 

%decode
huffDecodedImg=huffmanDecoder(huffEncodedImg, diffCodebook);

% Validate that data is the same after en/de-codeing
status = isequal(diffEncodedImg(1:1000), huffDecodedImg);
if status == 1
    CodingOK='Yes'
end
if status == 0
    CodingOK='No'
end



%% 7. Draw block diagram for HuffmanEncoder
% Alex?











%% END


















