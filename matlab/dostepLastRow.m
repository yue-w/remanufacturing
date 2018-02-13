function m_matrixNew = dostepLastRow(m_matrix,columnVal)
    M = size(m_matrix,1);
%     %If this cell is not connect by any cells
%     connect = m_matrix(M,columnVal).connectUp;
%     if connect==0
%         value = 0;
%     else
%         buy = m_matrix(M,columnVal).buy;
%         r = computeR(M,connect, columnVal, buy);
%         value = r;
% 
%     end

    %if this cell is blocked, the value is the cost of opening it
    if m_matrix(M,columnVal).blocked == true
        m_matrix(M,columnVal).value = -costOpenCell(0,0,0);
        m_matrix(M,columnVal).buy = true;
        m_matrixNew = m_matrix;
    else
        m_matrix(M,columnVal).value = 0;
        m_matrixNew = m_matrix;
    end
    

end

function r=computeR(M,connect, columnV, buy)
    %M = size(m_matrix,1);
    if buy==true%this cell need to be open
        cost = costOpenCell(0,0,0);
        r=-cost-(min(columnV-connect))/(M-1);
    else
        r=-(min(columnV-connect))/(M-1);
    end
end