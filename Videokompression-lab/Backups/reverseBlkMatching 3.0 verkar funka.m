function [ reconstructedFrame ] = reverseBlkMatching( motionVectors, differenceBlocks, referenceImage, numPatchWidth, numPatchHeight )
%% 
% This function reconstructs a video frame using the input arguments by
% performing the inverse operations of those in blockMatching.m .

% If necessary, you can add block index corresponding to the image patch/motion
% vector to the input arguments.

% Input: see blockMatching.m 
% Output: the reconstructed video frame. 
%
%% Go through all the diffBlocks and reconstruct the frame

for i = 1:size(differenceBlocks,3)
    blockDifference = differenceBlocks(:,:,i);
    motionVector = motionVectors(i,:);
    index=i;
    
    %% Find the blocks' original position (upper left pixel)

    if mod(index, numPatchWidth) == 0
        startColumnPosition=8*numPatchWidth-7; 
    else
        startColumnPosition=8*mod(index,numPatchWidth)-7;
    end

    startRowPosition = 8*floor((index-1)/numPatchWidth)+1;
    
    startPosition = [startRowPosition,startColumnPosition];
    
    %% If the block is located round the edges, dont change anything.

    if mod(index, numPatchWidth) == 1 || mod(index, numPatchWidth) == 0 || floor((index-1)/numPatchWidth)+1 == 1 || floor((index-1)/numPatchWidth)+1 == numPatchHeight;
        break
    end
    
    %% Modify position with motion vector  
    
    newPosition = startPosition + motionVector;
    index
    newRow = newPosition(1)
    newCol = newPosition(2)
    
    
    %% Modify ReferenceImage with differences
   
    referenceImage(newCol:newCol+7, newRow:newRow+7)=referenceImage(newCol:newCol+7, newRow:newRow+7)+blockDifference;
         
end

%% After the loops: Modified referenceImage is now a reconstructed frame.

reconstructedFrame=referenceImage;     

end


