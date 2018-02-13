function m_matrixNew = findAndConnectPatches(m_matrix)
%Find all the patches that have not been connected in a chain, and connect
%them to form a chain
    m_matrixNew = m_matrix;
    [M,N] = size(m_matrix);
    
    %Stores the column values of the cells that not been used.
    columns = zeros(M,1);
%     for column = 1:N
%         down = m_matrix(1,column).connectDown;
%         if down>0
%             up = m_matrix(2,down).connectUp;
%             if up ~=column
%                 columns(1) = column;
%                 break;
%             end            
%         end
%     end
    
    %Find column patches from row 2 to M-1
    for row = 1:(M-1)
        for column = 1:N
            [conflict, brokenPnt,~] = checkThisChain(m_matrix,row,column);
            if conflict == true
%                 columns(row)=column;
%                 down = m_matrix(row,column).connectDown;                
%                 rowIn = row + 1;
%                 while(rowIn<=brokenPnt)
%                     columns(rowIn) = down;
%                      rowIn = rowIn + 1;
%                 end
                columns(row)=column;
                rowIn = row;
                while(rowIn<brokenPnt)
                    down = m_matrix(rowIn,column).connectDown;    
                    columns(rowIn+1)=down;
                    rowIn = rowIn + 1;
                end
                break;
            end
        end
    end
    
    %Check the last row
    if columns(M) ==0
        for column = 1:N
            up = m_matrix(M,column).connectUp; 
            down = m_matrix(M-1,up).connectDown; 
            if down ~= column
                columns(M) = column;
                break;
            end
        end        
    end

    %Check the cell that is not connected by the row above
    for row  = 2:M
        if columns(row) == 0
            [conflict,  columnV]= checkConflictUp(m_matrix,row); 
                if conflict == true
                    columns(row) = columnV;           
                rowDown = row + 1;
                while (rowDown<=M)
                    if columnV > 0
                        temColumn = m_matrix(rowDown-1, columnV).connectDown;
                        columns(rowDown) = temColumn;
                        rowDown = rowDown + 1;
                        columnV = temColumn;               
                    else
                        rowDown = rowDown + 1;
                    end
                end
               end 
        end
    end
   
    numberOfPatches = nnz(columns);
    if numberOfPatches==M
            %Connect the unconnected cells
            if columns(1)>0
                m_matrixNew(1,columns(1)).connectDown = columns(2);
            end
            for row = 2:(M-1)
                if columns(row)>0
                    m_matrixNew(row,columns(row)).connectUp = columns(row-1);
                    m_matrixNew(row,columns(row)).connectDown = columns(row+1);
                end          

            end
            if columns(M)>0    
                m_matrixNew(M,columns(M)).connectUp = columns(M-1);       
            end

%             %If connecting the patches makes the total score lower, do not connect
%             %them.
%             totalOld = computeTotalScore(m_matrix);
%             totalNew = computeTotalScore(m_matrixNew);
%             if totalOld>totalNew
%                 m_matrixNew = m_matrix;
%             end
    end

end