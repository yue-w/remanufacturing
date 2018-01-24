function price = computePrice(M, thisColum, nextColumn)
%For now, we do not consider the minimum RUL in the chain, we only consider
%the minimum RUL in this row and next row
    price = min(thisColum, nextColumn)/(M-1);
end