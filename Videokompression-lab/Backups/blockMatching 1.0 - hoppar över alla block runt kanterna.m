function [ motionVector, blockDifference ] = blockMatching( imageBlock, referenceImage, index , numPatchWidth, numPatchHeight)
%% Instruction (you might need to refer to specification of Project 3)
% This function calculates the motion vector and the difference of  
% certain block in a future frame with respect of the reference frame (referenceImage)

% Input:
% imageBlock: bwImg patch separated from a frame
% referenceImage: the image used as the reference to calculate the motion
% vector and the difference matrix

% Output:
% motionVector == a vector conatins offset value in vertical and horizontal
% direction that tells the receiver where to find its best matching from
% the referenceImage

% blockDifference == a matrix whose size euquals to imageBlock, in which each
% elements equals to imageBlock minus the best matching of imageBlock in referenceImage.
% You need to reshape it to a vector before 'transmission'.

% You can increase the number of input/output if necessary, e.g. the index of the imageBlock.

%% Note! 
% Realizing the functionality of searching the best matching for
% imageBlock in referenceImage can be implement here in terms of script, 
% subfunction or in a separate .m file
%%

referenceImage = double(referenceImage);

%Find the blocks' original position (upper left pixel) 
if mod(index, numPatchWidth) == 0
    startColumnPosition=8*numPatchWidth-7; 
else
    startColumnPosition=8*mod(index,numPatchWidth)-7;
end

startRowPosition=8*floor((index-1)/numPatchWidth)+1;

startColumnPosition; %bara för koll
startRowPosition;  % Bara för koll


minVec = [];

%%If the block is located round the edges, diff=0, motion =0
if mod(index, numPatchWidth) == 1 || mod(index, numPatchWidth) == 0 || floor((index-1)/numPatchWidth)+1 == 1 || floor((index-1)/numPatchWidth)+1 == numPatchHeight;
      index; %bara för koll
    
      motionVector=[0,0];
      blockDifference = zeros(8);
      return
end


%% for all the others, search 3 pixels around..

%skriv kod...

%%

% [minDiff, n] = min(minVec(:,1))
% 
% rows = minVec(n,3):minVec(n,3)+7;
% cols = minVec(n,2):minVec(n,2)+7;
% 
% blockDifference = imageBlock - referenceImage(rows,cols);
% 
% motionVector = [startRowPosition-minVec(n,3),startColumnPosition-minVec(n,2)];




%bara för test:        (kommentera bort ovan)
blockDifference = ones(8);

motionVector = [1,1];


end

