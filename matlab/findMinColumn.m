function minColumn = findMinColumn(m_matrix, rowVal,columnVal,connect)
%This function find the minmimum column in the chain that contains the cell
%m_matrix(rowVal,columnVal). Return it to minColumn
    M = size(m_matrix,1);
    %search up
    row = rowVal;
    minColumn = columnVal;
    while row>1
        temColumn = m_matrix(row,columnVal).connectUp;
        if temColumn < minColumn
            if temColumn> 0
               down = m_matrix(row-1,temColumn).connectDown;
               if down == columnVal%If this connection is effective
                   minColumn = temColumn;
               else
                   break;
               end
               columnVal = temColumn;
            else
                break;
            end
        else
            columnVal = temColumn;
        end
        row = row - 1;
    end
    
    %Search down
    minColumn = min([minColumn,connect]);
    row = rowVal+1;
    while row < M
        temColumn = m_matrix(row,connect).connectDown;
        if temColumn < minColumn
            if temColumn> 0
                up = m_matrix(row+1,temColumn).connectUp;
                if up == connect%If this connection is effective
                    minColumn = temColumn;
                else
                    break;
                end
                connect = temColumn;
            else
                break;
            end
        else
            connect = temColumn;
        end
        row = row + 1;
    end
    
end