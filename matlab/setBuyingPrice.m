function m_matrix_New = setBuyingPrice(m_matrix)
%Set the price of buying new components
    [~,N] = size(m_matrix);
    for col = 1:N
        %Cylinder Block
        m_matrix(1,col).price = 0.42;
        %Cylinder Head
        m_matrix(2,col).price = 0.25;
        %Flywhell housing
        m_matrix(3,col).price = 0.03;
        %Gearbox
        m_matrix(4,col).price = 0.03;
        %Connecting-rod
        m_matrix(5,col).price = 0.07;
        %Crankshaft
        m_matrix(6,col).price = 0.17;
        %Fly whell
        m_matrix(7,col).price = 0.02;      
    end
    
    %m_matrix(2,3).price = 0.2;
    %m_matrix(3,2).price = 3.1;
    
    %m_matrix(3,3).price = 1.1;
    %m_matrix(3,4).price = 3.1;
m_matrix_New = m_matrix;  
end