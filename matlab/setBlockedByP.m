function m_matrixNew = setBlockedByP(m_matrix)
%Set the cell to be blocked whether the sell is blocked according to p.
    [M,N] = size(m_matrix);
    for row = 1:M
        for col = 1:N
            p = m_matrix(row,col).pBlocked;
            randV = rand();
            if(randV<p)
                m_matrix(row,col).blocked = true;
            end
        end
    end
m_matrixNew = m_matrix;
end