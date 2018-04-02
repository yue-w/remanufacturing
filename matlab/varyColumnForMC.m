function [columnValNew,connectNew] = varyColumnForMC(columnVal,connect,sigma,lowBnd,upBnd)
%This function generate the value of this cell and the cell it connect
%to according to the probability   
    temCol = normrnd(columnVal,sigma);
    columnValNew = round(temCol);
    
    %If the score exceed lower bound or up bound, set it to lower bound and
    %up bound
    if columnValNew<lowBnd
        columnValNew = lowBnd;
    end
    if columnValNew>upBnd
        columnValNew = upBnd;
    end
     
    temConnect = normrnd(connect,sigma);
    connectNew = round(temConnect);    
    if connectNew<lowBnd
        connectNew = lowBnd;
    end
    if connectNew>upBnd
        
       connectNew = upBnd;
    end

end