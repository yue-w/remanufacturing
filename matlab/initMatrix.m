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
   
%    %Test
%    m_matrix(1,1).connectDown = 4;
%    m_matrix(2,4).connectUp = 1; m_matrix(2,4).connectDown=3;
%    m_matrix(3,3).connectUp = 4; m_matrix(3,3).connectDown = 4;
%    m_matrix(4,4).connectUp = 3;
%    
%    m_matrix(1,2).connectDown = 1;
%    m_matrix(2,1).connectUp = 2; m_matrix(2,1).connectDown = 1;
%    m_matrix(3,1).connectUp = 1; m_matrix(3,1).connectDown=1;
%    m_matrix(4,1).connectUp = 1;
%    
%     m_matrix(1,3).connectDown = 2;
%     m_matrix(2,2).connectUp = 3; m_matrix(2,2).connectDown = 4;
%     m_matrix(3,4).connectUp = 2; m_matrix(3,4).connectDown = 2;
%     m_matrix(4,2).connectUp = 4;
%      
%     m_matrix(1,4).connectDown = 3;
%     m_matrix(2,3).connectUp = 4; m_matrix(2,3).connectDown = 2;
%     m_matrix(3,2).connectUp = 3; m_matrix(3,2).connectDown = 3;
%     m_matrix(4,3).connectUp = 2;
%    %Test
   
   
   m_matrix_New = m_matrix;
end