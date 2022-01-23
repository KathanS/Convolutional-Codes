gammaDB = 0:0.5:8;
gammaLin = 10.^(gammaDB/10);
Nsim = 1;
k = 500;
r = 1/2;
pBitError = zeros(1,length(gammaDB))-1; 

for i = 1:length(gammaLin)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder(k);
        receivedCode = channelAWGN(encodedMessage,gammaLin(i),r);
        estimatedMessage = softDecoder(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end

plot(gammaDB,pBitError);