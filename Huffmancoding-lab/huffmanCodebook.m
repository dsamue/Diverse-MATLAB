function [ CodeBook ] = huffmanCodebook( imgBW )
%% 
% This function construct huffman dictionary from a BW training image
% Input: imgBW is a UINT8 black and white image
% Output: CodeBook, with 256 codewords corresponding to 256 grayscale levels
% Note: Some of the codeword might be null.  
%256x2 cell array if modificated in end, else 256x1

% You can add the input/output arguments if needed.
%% Probability Vector

p = histc(imgBW(:),0:255);          %Creates histogram of values.
p = p/(1280*720);                   %Calculates probability for each value.

%% Entropy
%Calculates entropy.

E=0;
for i = 1:256
    P=p(i);
    if P ~= 0
        E = E +(-(P*log2(P)));
    end
end

%% Huffman Tree
%Uses the values' probabilities to create a cell array with Huffman tree
%characteristics.

tree = cell(256,1);     %Creates empty 256x1 cell array.

[p,i]=sort(p);          %Creates two vectors; one with sorted probabilities 
                        %in ascending order, and another with values sorted 
                        %corresponding to probabilities.
                        
i = i - 1;              %Corrects values from 1-256 to 0-255.

for k = 1:256 %Puts values in cell array in order of ascending probability.
    tree{k} = i(k);                 
end

while length(tree) > 2   %Puts all values in a Huffman tree cell array.
                         %In the finished tree, each cell contains either
                         %a value or another 1x2 cell array.
    min = 1.0;
    for k = 1:length(p)-1             %Finds the two adjacent probabilities 
                      %(corresponding to values) with the least difference.
        difference = abs(p(k)-p(k+1));
        if difference < min          %Remembers the position of adjacent    
                                     %probabilities with least difference 
                                     %and corresponding values.
            min = difference;
            pos = k;
        end
    end
    %Takes the two values and puts them into binary branches 
    %in the cell array at the same position.
    tree{pos} = {tree{pos}, tree{pos+1}};
    %Removes adjacent value to construct binary tree arrangement.
    tree(pos+1) = [];    
    %Adds corresponding probabilities and replaces old probability.
    p(pos) = p(pos) + p(pos+1);
    %Removes old adjacent probability.
    p(pos+1) = [];                          
end
%Rearranges top two cell arrays to match rest of the tree.
tree = {tree{1}, tree{2}};

%% CodeBook
%Writes a codebook for the values based on their Huffman tree arrangement.

CodeBook = codewriter(tree, []);

%% Modifications that makes the codebook a 256x2 cell array (like huffdict)

% values=cell(256,1);
% for i = 0:255 %Puts values in cell array in order of ascending probability.
%     values{i+1} = i;  
% end
%     
% values(:,2)=CodeBook;
% CodeBook = values;