function m_matrix_New = setBuyingPrice(m_matrix)
% %Set the price of buying new components
%      [M,N] = size(m_matrix);
%      for row = 1:M
%          for col = 1:N
%              
%          end
%      end
    m_matrix(2,3).price = 3.1;
    m_matrix(3,2).price = 3.1;
    %m_matrix(3,3).price = 1.1;
    m_matrix(3,4).price = 3.1;
m_matrix_New = m_matrix;  
end