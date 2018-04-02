function UT(m_matrix)
%Number of row (# of components)
M=7;
%Number of column (# of Remaining Useful Year (RUL))
N=5;
discount = 1;
maxIterate = 100;
tolerance = 0.001;
numMonteCarlo = 4;  

m_cell.value = 0;
m_cell.connectUp = 0;
m_cell.connectDown = 0;
m_cell.blocked = false;
m_cell.buy = false;
%m_cell.RUL = 0;
m_cell.price = 0;
m_cell.pBlocked = 0;
pBlocked = 0;

m_matrix(M,N)=m_cell;

sigma = 0;
%Basic initialization
m_matrix = basicInit(m_matrix);

%Set the initial connection relationship
    m_matrix = initConnection(m_matrix);
    
%Set the probability that the cell to be blocked
    m_matrix = initpBlocked (m_matrix,pBlocked);
%Set the cell to be blocked according to the probability
    m_matrix = setBlockedByP(m_matrix);
    
    
%     m_matrix(2,3).blocked = true;
%     m_matrix(2,3).price = 3.1;
%         
%     m_matrix(3,2).blocked = true;
%     m_matrix(3,2).price = 3.1;
    
    %m_matrix(3,3).blocked = true;
    %m_matrix(3,3).price =1.1;
    
%     m_matrix(3,4).blocked = true;
%     m_matrix(3,4).price = 3.1;



[m_matrix, iteTimes, scoreBeforeOpt, ~]= iterate(m_matrix,maxIterate,discount,tolerance,numMonteCarlo, sigma);
outPut(m_matrix,iteTimes,scoreBeforeOpt);
end