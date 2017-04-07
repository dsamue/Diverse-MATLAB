function [ motionVector, blockDifference ] = blockMatching( imageBlock, referenceImage )
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

startColumnPosition=(8*mod(index, patchwidth))+1

startRowIndex=8*floor((index-1)/patchWidth)+1;



end

