function [ encodedVector ] = diffEncoder( bwImg )
%%
% This function encodes a black n white image into a single vector using
% differential coding
% Input: bwImg == black image i.e. a Y frame

% Output: encoded bwImg, a vector formed by differentiated valus
% aBWframe = 
% [a1, a2, a3, ... , aN;
%  b1, b2, b3, ... , bN;
%  ... ... ...
%   ... ... ...
%     ...     ...   ...]
% 
% Do differential coding by new_a1 = a2-a1, new_a2 = a3-a2... for every row
% and keep the first column the same!
%%
bwImg = double(bwImg);
[height, width] = size(bwImg);

i=1;

for m = 1:height
    encodedVector(i) = bwImg(m,1); %first column should be the same
    i = i + 1;
    for n = 2:width
        encodedVector(i) = bwImg(m,n) - bwImg(m,(n-1)); %new_a1 = a2-a1
        i = i+1;
    end
end

