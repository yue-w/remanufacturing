function m_matrixNew = updateValuesLastRow(m_matrix)
%This function update the values of the cells
    [M,N] = size(m_matrix);
    m_matrixNew = m_matrix;
    for column = 1:N
        [conflict,brockenPnt,lastColumn] = checkThisChain(m_matrix,1, column);
        %If this chain does not connect to the last row
        if conflict == true
            %Set the values to be 0 
            row = 1;
            currentColumn = column;
            while(row<=brockenPnt)                
                m_matrixNew(row,currentColumn).value = 0;
                currentColumn =m_matrixNew(row,currentColumn).connectDown;
                row = row + 1;
            end
        %If this chain goes to the last row
        else
            [~,valuesUpDown] = computeCurrentValueColum(m_matrix,lastColumn);
            currentColumn = column;
            for row = 1:(M-1)
                m_matrixNew(row,currentColumn).value = valuesUpDown(row);
                currentColumn = m_matrixNew(row,currentColumn).connectDown;
            end
        end
    end
end