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

%% Select first frame from the video
Frame1 =  double(mov(1).cdata);
Frame1 = Frame1(:,:,1)/3+Frame1(:,:,2)/3+Frame1(:,:,3)/3;   % Make a quick grayscale frame (equal Y)
Frame1 = imresize(Frame1, 0.1);

%% Select next one  (valde en helt annan bara för att få lite skillnad)
Frame2 =  double(mov(90).cdata);
Frame2 = Frame2(:,:,1)/3+Frame2(:,:,2)/3+Frame2(:,:,3)/3;   % Make a quick grayscale frame (equal Y)
Frame2 = imresize(Frame2, 0.1);

%% Make blocks
[Patches, patchWidth] = patchImage(Frame2,8,8);

numPatches=size(Patches,3);                 % Number of patches total
numPatchWidth=patchWidth;                    % Number of patches for width 
numPatchHeight=numPatches/numPatchWidth;     % Number of patches for height

%% Blockmatching
motionVectors=[];
differenceBlocks=zeros(8);

for i = 1:size(Patches,3)
    [motionVectors(i,:), differenceBlocks(:,:,i)] = blockMatching(Patches(:,:,i), Frame1, i, numPatchWidth, numPatchHeight);
end

    
    