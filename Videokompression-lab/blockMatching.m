function [ motionVector, blockDifference ] = blockMatching...
    (imageBlock, referenceImage, index , numPatchWidth, numPatchHeight)

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
minVec = [];


%% Find the blocks' original position (upper left pixel)

if mod(index, numPatchWidth) == 0
    startCol=8*numPatchWidth-7; 
else
    startCol=8*mod(index,numPatchWidth)-7;
end

startRow=8*floor((index-1)/numPatchWidth)+1;


%% If the block is located round the edges, dont look in search window.

if mod(index, numPatchWidth) == 1 ||...                     % First column
   mod(index, numPatchWidth) == 0 ||...                     % Last column
   floor((index-1)/numPatchWidth)+1 == 1 ||...              % First row
   floor((index-1)/numPatchWidth)+1 == numPatchHeight;      % Last row
    
      motionVector=[0,0];
      block = referenceImage(startRow:startRow+7,startCol:startCol+7); 
      blockDifference = imageBlock-block;
      return
end



%% for all the others, search 4 pixels around..

for i = startCol-4:startCol+4 

    for j = startRow-4:startRow+4

        block = referenceImage(j:j+7,i:i+7); 
        %8x8 block from referenceImage

        minVec = [minVec ; sum(sum(abs(imageBlock-block))), j , i]; 
        %For each try, save difference and position in minVec

    end
end



%% Find the block that is most similar and create diffblock motion vector

[minDiff, n] = min(minVec(:,1));        %Find best matched block

rows = minVec(n,2):minVec(n,2)+7;       %Take position
cols = minVec(n,3):minVec(n,3)+7;

blockDifference = round(imageBlock - referenceImage(rows,cols)); 
%Take difference 

motionVector = [minVec(n,2)-startRow,...
                minVec(n,3)-startCol];
%Create motion vector


end

