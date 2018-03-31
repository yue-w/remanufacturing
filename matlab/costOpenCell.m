%This cost can be changed to constant
%rowM is the number of row, columnN is the number of column
function costOpen = costOpenCell(m_matrix,rowM,columnN)
    %cost = -abs(columnN+1-columnVal)/rowM;
    %cost=-1/rowM;
    %costOpen = 0;
    costOpen = m_matrix(rowM,columnN).price;
end