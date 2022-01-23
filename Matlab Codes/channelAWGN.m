function output = channelAWGN(input,gammaLin,r)
    variance = 1/(2*r*gammaLin);      % variance <--> sigmaSquare
    output = 2*input-1+sqrt(variance)*randn(1,length(input));