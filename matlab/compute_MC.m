function newV = compute_MC(m_matrix,rowVal,columnVal,connect,NUM,sigma)
%This function compute the expected score of this pair using Monte Carlo
%NUM is the number of experiments
discount = 1;
    sumV = 0;
    for i = 1:NUM
        %Vary the value of columnVal and connect according to probability
        lowBnd = 1;
        upBnd = size(m_matrix,2);
        [columnVal,connect] = varyColumnForMC(columnVal,connect,sigma,lowBnd,upBnd);
        
        r = computeR(m_matrix,rowVal,columnVal,connect);
        v = computeV(m_matrix,rowVal,connect,discount);
        sumV = (sumV + r + v);
    end
    
    
    newV = sumV/NUM;    
end

function r = computeR(m_matrix,rowVal,columnVal,connect)
    [M,N] =  size(m_matrix);
    
    %Method One
    r = computePrice(M,columnVal,connect);
    %Method Two
    %r = computePriceMin(m_matrix, rowVal,columnVal,connect);
end

function v= computeV(m_matrix,rowVal,columnVal, discount)
    M =  size(m_matrix,1);
    v = 0;
    if columnVal>0
        v = m_matrix(rowVal+1, columnVal).value;
    end
    
end