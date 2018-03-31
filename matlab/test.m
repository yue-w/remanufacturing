% %This is test
% M = 4;
% N = 4;
% 
% m_cell.connectUp = 0;
% m_cell.connectDown = 0;
% m_matrix(M,N)=m_cell;

% %First Row
% randDown = randperm(N);
% for col = 1:N
%    m_matrix(1,col).connectUp = 0;
%    m_matrix(1,col).connectDown = randDown(col);
%    m_matrix(2,randDown(col)).connectUp = col;
% end
% 
% %From the second to the second last row
% for row = 2:(M-1)
%    randDown = randperm(N);
%    for col = 1:N
%        m_matrix(row,col).connectDown = randDown(col);
%        m_matrix(row+1,randDown(col)).connectUp = col;
%    end
% end
% 
% %Last Row
% for col = 1:N
%     m_matrix(M,col).connectDown = 0;
% end
