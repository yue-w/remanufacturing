function m_matrix_New = setBuyingPrice(m_matrix,scaleFactor)
%Set the price of buying new components
    [~,N] = size(m_matrix);
    for col = 1:N
        %Cylinder Block
        m_matrix(1,col).price = 0.42*scaleFactor;
        %Cylinder Head
        m_matrix(2,col).price = 0.25*scaleFactor;
        %Flywhell housing
        m_matrix(3,col).price = 0.03*scaleFactor;
        %Gearbox
        m_matrix(4,col).price = 0.03*scaleFactor;
        %Connecting-rod
        m_matrix(5,col).price = 0.07*scaleFactor;
        %Crankshaft
        m_matrix(6,col).price = 0.17*scaleFactor;
        %Fly whell
        m_matrix(7,col).price = 0.02*scaleFactor;  
    end
    
    %m_matrix(2,3).price = 0.2;
    %m_matrix(3,2).price = 3.1;
    
    %m_matrix(3,3).price = 1.1;
    %m_matrix(3,4).price = 3.1;
m_matrix_New = m_matrix;  
end