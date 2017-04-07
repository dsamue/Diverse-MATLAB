function [ v ] = codewriter( tree, code )
%%
%This function takes in a Huffman tree and creates a unique binary code for
%each value. It uses a vector of ones and zeros as input to keep building
%codes for the values, starting at an empty vector when called by
%huffmanCodebook function.

%Input: tree = Cell array of Huffman binary tree characteristics, each cell
%containing either an integer or another 1x2 cell array.
%code = Vector containing ones and zeros, or empty.

%Output: v = Codebook in form of a cell array, each cell containing a 
%vector of integers 0 and 1.
%% Code Writer


%Creates cell array that will contain all code vectors in position of
%corresponding value.
v = [];

%If the branch ends to the left, adds a 0 to the current code and puts it
%in a cell at the position of corresponding value. 
if size(tree{1}, 2) == 1                  
    bin = [code 0];
    bin = {bin};
    v = [v bin];
end

%If left branch contains 1x2 cell, adds a 0 to the current code and
%recursively calls codewriter function on left cell array.
if size(tree{1}, 2) == 2                
    temp = [code 0];
    u = codewriter( tree{1}, temp );
    v = [v u];
end

%If the branch ends to the right, adds a 1 to the current code and puts it
%in a cell at the position of corresponding value.
if size(tree{2}, 2) == 1                
    bin = [code 1];
    bin = {bin};
    v = [v bin];
end

%If right branch contains 1x2 cell, adds a 1 to the current code and
%recursively calls codewriter function on right cell array.
if size(tree{2}, 2) == 2                
    temp = [code 1];
    w = codewriter( tree{2}, temp );
    v = [v w];
end
