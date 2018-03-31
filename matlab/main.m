%Number of row (# of components)
M=4;
%Number of column (# of Remaining Useful Year (RUL))
N=4;

%Array of Remaining Useful Year (RUL)
RULs = (1:N);

%Price of buying a new part. Array. all component is 1.1 in this example.
%price = 0.2; this is modified in the function costOpenCell() in dostep.m
%%newPrice = price*ones(1:M);

discount = 1;

m_cell.value = 0;
m_cell.connectUp = 0;
m_cell.connectDown = 0;
m_cell.blocked = false;
m_cell.buy = false;
%m_cell.RUL = 0;
m_cell.price = 0;
m_cell.pBlocked = 0;

m_matrix(M,N)=m_cell;

% %Initialize the matrix
% for i= 1:M
%     for j = 1:N
%         m_cell.RUL = RULs(j);
%         %In this example, the selling price is the same with RUL
%         m_cell.price = RULs(j);
%         m_matrix(i,j)= m_cell;
%     end
% end


m_matrix = initMatrix(m_matrix);
%m_matrix = modifyInPut(m_matrix);

maxIterate = 100;
%Asynchronous
m_matrix= iterate(m_matrix,maxIterate,discount);
%Synchronous
%m_matrix= iterateSynchronous(m_matrix,maxIterate,discount);
outPut(m_matrix);





