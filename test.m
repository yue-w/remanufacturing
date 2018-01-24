%     m_cell.value = 0; m_cell.connectUp = 0; m_cell.connectDown = 0;
%     matrix(2,3) = m_cell;
%     
%     for column = 1:3
%         matrix(1,column).connectDown = column;
%         matrix(2,column).connectUp = column;
%         matrix(1,column).value = column;
%     end
%     matrix(2,1).connectUp = 2;
%     result = computeTotalScore(matrix);

%     f = figure;
%     dataM = magic(3);
%     t = uitable(f, 'Data',dataM,'Position',[5,5,300,300]);
% 
%     i = 0;
%     while i<10
%         if i==3
%             i = i+1;
%             continue;
%         end
%         fprintf('value is: %d \n', i);
%         i = i+1;
%     end
% result1 = 1;
% result2 = 2;

function test=test()


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
m_cell.RUL = 0;
m_cell.price = 0;

m_matrix(M,N)=m_cell;

%Initialize the matrix
for j = 1:N
    m_cell.RUL = RULs(j);
    %In this example, the selling price is the same with RUL
    m_cell.price = RULs(j);
    m_matrix(1,j)= m_cell;
    m_matrix(1,j).connectDown = j;
end
for j = 1:N
    m_cell.RUL = RULs(j);
    %In this example, the selling price is the same with RUL
    m_cell.price = RULs(j);
    m_matrix(M,j)= m_cell;
    m_matrix(M,j).connectUp = j;
end
for i= 2:(M-1)
    for j = 1:N
        m_cell.RUL = RULs(j);
        %In this example, the selling price is the same with RUL
        m_cell.price = RULs(j);
        m_matrix(i,j)= m_cell;
        %The following codes connect each cell to the cell below
        m_matrix(i,j).connectDown = j;
        m_matrix(i,j).connectUp = j;
    end
end
m_matrix(1,2).connectDown = 3;
m_matrix(2,3).connectUp = 2;

m_matrix(2,3).connectDown = 3;
m_matrix(3,3).connectUp = 3;

m_matrix(3,3).connectDown = 1;
m_matrix(4,1).connectUp = 3;

min = findMinColumn(m_matrix,1,2,3);
end