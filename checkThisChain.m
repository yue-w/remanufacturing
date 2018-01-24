function [conflict, brokenPnt,lastColumn]= checkThisChain(m_matrix,row, column)
%This function check whether this chain is effectivelly connected, starting
%from the cell (row,column).
%conflict = true means this chain is not effectivelly connect
%brokenPnt is the row from which the connection brocken. if conflict ==
%true, brokenPnt is less than M, otherwise, brokenPnt == M. (M is the total
%row of the matrix)
    conflict = false;
    M = size(m_matrix,1);
    down = 0;
    while row<M
        down = m_matrix(row, column).connectDown;
        if down > 0
            up = m_matrix(row+1,down).connectUp;
        else
            up = 0;
        end   
        if up ~= column
            conflict = true;
            break;
        end
        column = down;
        row = row + 1;
    end
    brokenPnt = row;
    if conflict == false
        lastColumn = down;
    else
        lastColumn = 0;
    end

end