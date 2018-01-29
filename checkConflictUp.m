function [conflict,column]= checkConflictUp(m_matrix,rowVal)
%Check whether the cell is connected by a cell in the row above
    [~,N] = size(m_matrix);
    conflict = false;
    column = 0;
    for columnIndex = 1:N
        if rowVal>1 
            up = m_matrix(rowVal, columnIndex).connectUp;
            if up>0        
                down = m_matrix(rowVal - 1, up).connectDown;
                if down~=columnIndex;
                    conflict = true;
                    column = columnIndex; 
                    break;
                end
            end
        end
    end
end