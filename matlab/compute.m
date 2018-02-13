function newV = compute(m_matrix,rowVal,columnVal,connect,discount)
        r = computeR(m_matrix,rowVal,columnVal,connect);
        v = computeV(m_matrix,rowVal,connect,discount);
        newV = r+discount*v;
end

function r = computeR(m_matrix,rowVal,columnVal,connect)
    [M,N] =  size(m_matrix);
    
    %Method One
    %r = computePrice(M,columnVal,connect);
    %Method Two
    r = computePriceMin(m_matrix, rowVal,columnVal,connect);
end

function v= computeV(m_matrix,rowVal,columnVal, discount)
    M =  size(m_matrix,1);
    v = 0;
    if columnVal>0
        v = m_matrix(rowVal+1, columnVal).value;
    end
end