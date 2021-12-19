function lossVal = LossFunction( netOut, yTrain )
    
    [ M, N ] = size( yTrain );

    %mse; M - poèet vzorù; N - poèet tøíd
    lossVal = (1/M)*(1/N)*sum( sum(( yTrain - netOut ).^2));
    
end