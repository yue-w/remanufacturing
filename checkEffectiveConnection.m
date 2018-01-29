function effective = checkEffectiveConnection(m_matrix,rowV,direction)
%Check whether the cell (rowV,columnV) has been used in a chain.
    effective = false;
    competeColumn = m_matrix(rowV+1,direction).connectUp;
    trueDown = m_matrix(rowV,competeColumn).connectDown;
    if direction == trueDown
        effective = true;
    end

end