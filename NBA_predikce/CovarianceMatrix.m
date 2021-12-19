function covMat = CovarianceMatrix(myData)
    %myData = [1 -4 0; 0 1 -2; -1 3 2];
    %covMat = cov(myData);
    M = size(myData,1);
    covMat = (1/(M-1))*(myData' * myData);
end