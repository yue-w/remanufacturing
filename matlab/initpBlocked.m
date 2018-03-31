function m_matrixNew= initpBlocked(m_matrix)
%Set the probability that the cell be missing
    [M,N] = size(m_matrix);
    for row = 1:M
        for col = 1:N
            m_matrix(row,col).pBlocked = 0;
        end
    end
    
    %For testing
    m_matrix(2,3).pBlocked = 1;
    m_matrix(3,2).pBlocked = 1;
    %m_matrix(3,3).pBlocked = 1;
    m_matrix(3,4).pBlocked = 1;
    %For testing
    
    m_matrixNew = m_matrix;
end