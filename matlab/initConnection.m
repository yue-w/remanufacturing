function m_matrix_New = initConnection(m_matrix)
%Initialize the connection of matrix
    [M,N] = size(m_matrix);
    %First Row
    randDown = randperm(N);
    for col = 1:N
       m_matrix(1,col).connectUp = 0;
       m_matrix(1,col).connectDown = randDown(col);
       m_matrix(2,randDown(col)).connectUp = col;
    end

    %From the second to the second last row
    for row = 2:(M-1)
       randDown = randperm(N);
       for col = 1:N
           m_matrix(row,col).connectDown = randDown(col);
           m_matrix(row+1,randDown(col)).connectUp = col;
       end
    end

    %Last Row
    for col = 1:N
        m_matrix(M,col).connectDown = 0;
    end
    
%     for j = 1:N
%         %m_cell.RUL = RULs(j);
%         %In this example, the selling price is the same with RUL
%         %m_cell.price = RULs(j);
%         m_matrix(1,j)= m_cell;
%         %m_matrix(1,j).connectDown = j;
%         m_matrix(1,j).connectDown = N-j+1;
%     end
%     for j = 1:N
%         %m_cell.RUL = RULs(j);
%         %In this example, the selling price is the same with RUL
%         %m_cell.price = RULs(j);
%         m_matrix(M,j)= m_cell;
%         %m_matrix(M,j).connectUp = j;
%         m_matrix(M,j).connectUp = N-j+1;
%     end
%     for i= 2:(M-1)
%         for j = 1:N
%             %m_cell.RUL = RULs(j);
%             %In this example, the selling price is the same with RUL
%             %m_cell.price = RULs(j);
%             m_matrix(i,j)= m_cell;
%             %The following codes connect each cell to the cell below
%             %m_matrix(i,j).connectDown = j;
%             %m_matrix(i,j).connectUp = j;
%             m_matrix(i,j).connectDown = N-j+1;
%             m_matrix(i,j).connectUp = N-j+1;
%         end
%     end
   m_matrix_New = m_matrix;
end