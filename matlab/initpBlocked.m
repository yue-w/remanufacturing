function m_matrixNew= initpBlocked(m_matrix,p)
%Set the probability that the cell be missing
    [M,N] = size(m_matrix);
    for row = 1:M
        for col = 1:N
            m_matrix(row,col).pBlocked = p;
        end
    end
   
    
    m_matrixNew = m_matrix;
end