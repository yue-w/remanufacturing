function m_matrixNew = modifyInPut(m_matrix)
    %m_matrix(3,2).blocked = true;
    %m_matrix(1,3).blocked = true;
    %m_matrix(2,3).blocked = true;
    m_matrix(3,2).blocked = true;
    %m_matrix(3,3).blocked = true;
    %m_matrix(3,1).blocked = true;
    %m_matrix(3,4).blocked = true;
    %m_matrix(1,1).blocked = true;
    %m_matrix(2,1).blocked = true;
    m_matrixNew = m_matrix;
end