function m_matrix_New = initMatrix(m_matrix,pBlocked)

%Basic initialization
m_matrix = basicInit(m_matrix);

%Set the initial connection relationship
    m_matrix = initConnection(m_matrix);
    
%Set the probability that the cell to be blocked
    m_matrix = initpBlocked (m_matrix,pBlocked);
%Set the cell to be blocked according to the probability
    m_matrix = setBlockedByP(m_matrix);
%Set the price of buying the blocked component
   m_matrix = setBuyingPrice(m_matrix);
   
   
   
   m_matrix_New = m_matrix;
end