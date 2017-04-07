%% Pro 3  - Grupp 5
%Sanna Marklund, Alexander Johansson, David Samuelsson
clear all; close all; clc

%% Define video file path
file  = 'testABCD.mp4'; % the location your video is stored 

%% Read and generate a movie
vidObj = VideoReader(file); % obj generation 
nFrames = vidObj.NumberOfFrames;
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;

% Preallocate movie structure.
mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);

% Read one frame at a time.
for k = 1 : nFrames
    mov(k).cdata = read(vidObj, k);
end

%% Make structure for matched patches
   MatchPathes=cell(1,2);
   

%% Select reference frame from the video

Frame1 = double(mov(1).cdata);
Frame1 = Frame1(:,:,1)/3+Frame1(:,:,2)/3+Frame1(:,:,3)/3;   
% Make a quick grayscale frame (equal Y)

Frame1 = imresize(Frame1, 0.2);
referenceFrame = Frame1;

%% Make normal patches from ref. image
[Patches1, patchWidth] = patchImage(referenceFrame,8,8);
motionVector=zeros(144,2);                    %Made up motion vector

MatchPatches{1,1} = Patches1;                   
MatchPatches{1,2} = motionVector;

numPatches=size(Patches1,3);                 % Number of patches total
numPatchWidth=patchWidth;                    % Number of patches for width 
numPatchHeight=numPatches/numPatchWidth;     % Number of patches for height

%% Select coming frames

for i = 2:15
    
    Frame = double(mov(i).cdata);
    Frame = Frame(:,:,1)/3+Frame(:,:,2)/3+Frame(:,:,3)/3;   
    % Make a quick grayscale frame (equal Y)

    Frame = imresize(Frame, 0.2);

    %% Make patches
    [Patches, patchWidth] = patchImage(Frame,8,8);


    %% Blockmatching
    motionVectors=[];
    differenceBlocks=zeros(8);
    
    % Go through all patches in one frame
    for n = 1:size(Patches,3)
        [motionVectors(n,:), differenceBlocks(:,:,n)] =... 
        blockMatching(Patches(:,:,n), referenceFrame, n, numPatchWidth, numPatchHeight);
    end
    
    %% Save to structure
    MatchPatches{i,1} = differenceBlocks;
    MatchPatches{i,2} = motionVectors;
    
end
    

%% Huffman Encode






%% Reverse Blockmatching

Frames=zeros(144,256,15);
Frames(:,:,1)=referenceFrame;                                                %Lite fult. borde sätta ihop patcharna i första bilden ist..

for i = 2:15
    
    differenceBlocks = MatchPatches{i,1};
    motionVectors = MatchPatches{i,2};

    reFrame = reverseBlkMatching(motionVectors, differenceBlocks,...
                         referenceFrame, numPatchWidth, numPatchHeight);
    Frames(:,:,i)=reFrame;
end

Frames=uint8(Frames);


%% Save as videofile


% %Create a videoobject to write to
% writerObj = VideoWriter('Show.avi','Grayscale AVI');
% open(writerObj);
% 
% %Write frames
% nFrames=size(Frames,3);  %Number of frames
% 
% for i = 1:nFrames 
%     writeVideo(writerObj, Frames(:,:,i)); %Write frame to videofile
% end
% 
% %% Close the Video File
% close(writerObj);

    
    