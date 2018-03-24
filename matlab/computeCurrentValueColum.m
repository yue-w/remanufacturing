function [value,valuesUpDown] = computeCurrentValueColum(m_matrix,anchor)
discount = 1; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Modify!
%Compute the score of this chain (Trace up from the last cell). Instead of just read the score of the
%cell in the first row of this chain, this function compute the score by
%the connections. Because the score in the cells might not have been updated yet.
%All the values of the cells in this chain is stored in valuesUpDown, from
%the first row to the last row
    m_matrixNew = m_matrix;
    [M,N] = size(m_matrix);
    valuesUpDown = zeros(M,1);
    row = M;
    %m_matrixNew(row,anchor).connectUp = 
    %score = 0;
    while row>1
        columnVal = m_matrix(row,anchor).connectUp;
        row = row -1;
        cost = 0; 
        if (row>0 && columnVal>0)
            if m_matrixNew(row,columnVal).blocked == true
                cost = costOpenCell(0,0,0);
            end
            
        end
        if (row>0 && columnVal>0)
            temV = -cost + compute(m_matrixNew,row,columnVal,anchor,discount);
            m_matrixNew(row,columnVal).value = temV;
            valuesUpDown(row) = temV;
            anchor = columnVal;
        end
    end
    value = m_matrixNew(1,anchor).value;
end