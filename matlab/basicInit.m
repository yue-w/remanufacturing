function m_matrix_New = basicInit(m_matrix)
%Basic initialization of the matrix
    m_cell.value = 0;
    m_cell.connectUp = 0;
    m_cell.connectDown = 0;
    m_cell.blocked = false;
    m_cell.buy = false;
    %m_cell.RUL = 0;
    m_cell.price = 0;
    m_cell.pBlocked = 0;
    [M,N] = size(m_matrix);
    for row = 1:M
        for col = 1:N
         m_matrix(row,col) = m_cell;
        end
    end
m_matrix_New = m_matrix;
end