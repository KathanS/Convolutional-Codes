clearvars;
clc;
gammaDB = 0:0.5:8;
gammaLin = 10.^(gammaDB/10);
Nsim = 200;
k = 500;
r = 1/2;
%p = qfunc(sqrt(2*r*gammaLin));
p = [0.1587    0.1447    0.1309    0.1173    0.1040    0.0912    0.0789    0.0673    0.0565    0.0466    0.0377    0.0298    0.0230    0.0173    0.0126    0.0089    0.0060];
pBitError = zeros(1,length(gammaDB))-1; 

for i = 1:length(p)
    Nerror = 0;
    [encodedMessage,message] = encoder(k);
    for j = 1:Nsim
        receivedCode = channelAWGN(encodedMessage,gammaDB(i),1/2);
        estimatedMessage = softDecoder(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i*Nsim);
    pBitError(i) = Nerror/(k*Nsim);
end

semilogy(gammaDB,pBitError);