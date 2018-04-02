function score = checkPotentialRoutCompareExisting(m_matrix,rowVal,columnVal,potentialDirection,NUMofMC,sigma)

    score = 0; 
    m_matrixNew = m_matrix;
     %the cell bellow is brocken
     brockenRow1 = rowVal;
     brockenColumn1 = m_matrixNew(rowVal+1,columnVal).connectUp;
 
    m_matrixNew(rowVal,columnVal).connectDown = potentialDirection;
    if potentialDirection~=0
        m_matrixNew(rowVal+1,potentialDirection).connectUp = columnVal; %Wait a second, this cell might not connect up to m_matrix(rowVal,columnVal)
    end
 
 %Find a cell that has not been connected to other cells
 brockenRow2 = rowVal+1;
 brockenColumn2=1;
 %dir = m_matrixNew(brockenRow2,brockenColumn2).connectUp;
 find = false;
 N = size(m_matrixNew,2);
 while brockenColumn2 <= N
     dir = m_matrixNew(brockenRow2,brockenColumn2).connectUp;
     if dir >0 && rowVal>0
         if m_matrixNew(rowVal,dir).connectDown ~= brockenColumn2
             find = true;
             break;
         end
     end
     brockenColumn2 = brockenColumn2 +1;

 end
 
 %Make a new connection
 if find== true
     if brockenColumn1>0 && brockenColumn2>0
         m_matrixNew(brockenRow1,brockenColumn1).connectDown = brockenColumn2;
         m_matrixNew(brockenRow2,brockenColumn2).connectUp = brockenColumn1;
     end
 end
 
     %Find the column of the last cell in this new chain
    M = size(m_matrix,1);
    row = brockenRow2;
    LastIndex = brockenColumn1;
    while(row<M)
        if (row>0 && LastIndex>0)
            LastIndex = m_matrixNew(row,LastIndex).connectDown;           
        end
        row = row + 1;
    end
    if LastIndex>0
        [score,valuesUpDown]= computeCurrentValueColum(m_matrixNew,LastIndex,true,NUMofMC,sigma);  
    end
end