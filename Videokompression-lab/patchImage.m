function [ imagePatches,numPatchWidth ] = patchImage( bwImg, blockHeight, blockWidth)
%% Summary of this patchImage goes here
% This function segments an input image/frame into a number of
% non-overlapping patches as the output.
%   Detailed explanation goes here
%   Input:
%   aBWFrame is a black and white image or frame to be segmented
%   patchWidth and patchHeight define the size of segmented image patches
%   in the output. 
%   Output: 
%   imagePatch is a matrix whose 
%   size == patchWidth * patchHeight * numPatch
%   numPatch is the total number of image patch can be segmented from the
%   image by this function

%   Note that! patchImage function should be able to handle the cases when
%   width/height of the input frame is not exactly integer times of 
%   patchWidth/patchHeight


[imHeight, imWidth] = size(bwImg);           %Dimensions of input image 
i=1;                                         

imagePatches = zeros(blockHeight,blockWidth);  %Empty structure for patches
numPatchWidth=floor(imWidth/blockWidth);     %Number of patches row-wise

for by = 0 : floor(imHeight/blockHeight)-1
    for bx = 0 : floor(imWidth/blockWidth)-1 %0:(num of block that fits)-1 
    xi = 1+bx*blockWidth : (bx+1)*blockWidth;%First round 1:8 for 8x8 block 
    yi = 1+by*blockHeight : (by+1)*blockHeight;

    imagePatches(:,:,i) = bwImg(yi,xi); %Every patch in new layer
    
    i = i + 1;
  end
end

