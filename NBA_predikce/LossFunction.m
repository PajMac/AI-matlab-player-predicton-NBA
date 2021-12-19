function lossVal = LossFunction( netOut, yTrain )
    
    [ M, N ] = size( yTrain );

    %mse; M - po�et vzor�; N - po�et t��d
    lossVal = (1/M)*(1/N)*sum( sum(( yTrain - netOut ).^2));
    
end