function price = computePriceMin(m_matrix, rowVal,columnVal,connect)
%This function compute the revenue in this combination using the smallest
%RUL in this chain
    M = size(m_matrix,1);
    minColumn=findMinColumn(m_matrix, rowVal,columnVal,connect);
    price = minColumn/(M-1);
end