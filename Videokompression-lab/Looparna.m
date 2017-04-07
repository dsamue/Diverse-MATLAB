if or(startColumnPosition < 5,  startRowPosition < 5) % om startkolumn/rad ?r utanf?r bilden
    

    for i = startColumnPosition:startColumnPosition+18 %g?r  till 10 pixlar efter

        for j = startRowPosition:startRowPosition+18

            block = referenceImage(i:i+7,j:j+7); %tar ut 8x8 block

            minVec = [minVec ; sum(sum(abs(imageBlock-block))), i , j]; %sparar summan av skillnader

        end
    end
    
elseif or(startColumnPosition+18 > patchWidth*8,startRowPosition+18 > patchWidth*8) %om slutkolum/rad ?r utanf?r bild
    
    for i = startColumnPosition-10:startColumnPosition+7 %g?r fr?n 10 pixlar innan 

        for j = startRowPosition-10:startRowPosition+7

            block = referenceImage(i:i+7,j:j+7); %tar ut 8x8 block

            minVec = [minVec ; sum(sum(abs(imageBlock-block))), i , j]; %sparar summan av skillnader

        end
    end
    
else
    
    for i = startColumnPosition-5:startColumnPosition+13 %g?r fr?n 5 pixlar innan till 5 pixlar efter

        for j = startRowPosition-5:startRowPosition+13

            block = referenceImage(i:i+7,j:j+7); %tar ut 8x8 block

            minVec = [minVec ; sum(sum(abs(imageBlock-block))), i , j]; %sparar summan av skillnader

        end
    end
    
end