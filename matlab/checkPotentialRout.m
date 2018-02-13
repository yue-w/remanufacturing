function score = checkPotentialRout(m_matrix,rowVal,oldDirection, newDirection)
%Check whether there are potential connections when a new connection is
%made and old connection is brocken.
%if there are potential connections, value will be the score of the
%potential connection. If there is no possible connection, score is 0;
    score = 0;
    m_matrixNew = m_matrix;
    %The coordinate of the cell that has been unconnected (because old 
    %connection is replaced by new connection). The connections
    %above is broken, but the connections below is not affected.
    oldBrokeRow = rowVal + 1;
    oldBrokeColumn = oldDirection;
    
    %The coordinate of the cell that has been unconnected (because new 
    %connection is made). The connections below is broken, but the 
    %connections above is not affected.
    newBrokenRow = rowVal;
    newBrokeColumn = m_matrix(rowVal+1,newDirection).connectUp;
    
    %Make a new route from the broken connections
    if (newBrokenRow>0 && newBrokeColumn>0 && oldBrokeRow>0 && oldBrokeColumn>0  )
        m_matrixNew(newBrokenRow,newBrokeColumn).connectDown = oldBrokeColumn;
        m_matrixNew(oldBrokeRow,oldBrokeColumn).connectUp = newBrokeColumn;
    end
    %Find the column of the last cell in this new chain
    M = size(m_matrix,1);
    row = oldBrokeRow;
    LastIndex = oldBrokeColumn;
    while(row<M)
        if (row>0 && LastIndex>0)
            LastIndex = m_matrixNew(row,LastIndex).connectDown;           
        end
        row = row + 1;
    end
    if LastIndex>0
        score = computeCurrentValueColum(m_matrixNew,LastIndex);  
    end
    
end