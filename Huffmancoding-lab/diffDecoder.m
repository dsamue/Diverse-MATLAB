function [ decodedImg] = diffDecoder( encodedVector, height, width )
%%
%Do reverse operation to decode the output of diffEncoder function
%Reconstructs the image from the encoded Vector
%%

decodedImg = zeros(height, width);

i=1;

for m = 1:height
    decodedImg(m,1) = encodedVector(i); %first column should be the same
    i = i + 1;
    for n = 2:width
        decodedImg(m,n) = decodedImg(m,n-1)+encodedVector(i); 
        %new_a1 = a2-a1
        i = i+1;
    end
end

decodedImg = uint8(decodedImg);

end

