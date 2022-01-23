clearvars;
clc;
close all;
gammaDB = 0:0.5:8;
gammaLin = 10.^(gammaDB/10);
Nsim = 1;
k = 500;
r = 1/2;
%p = qfunc(sqrt(2*r*gammaLin));
p = [0.1587    0.1447    0.1309    0.1173    0.1040    0.0912    0.0789    0.0673    0.0565    0.0466    0.0377    0.0298    0.0230    0.0173    0.0126    0.0089    0.0060];
pBitError = zeros(1,length(gammaDB))-1; 

for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/2);
        receivedCode = channelBEC(encodedMessage,p(i));
        estimatedMessage = hardDecoder_Intermediate_1_2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end

semilogy(gammaDB,pBitError);
hold on;

for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/2);
        receivedCode = channelBSC(encodedMessage,p(i));
        estimatedMessage = hardDecoder_Intermediate_1_2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end

semilogy(gammaDB,pBitError);
hold on;

for i = 1:length(gammaLin)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/2);
        receivedCode = channelAWGN(encodedMessage,gammaLin(i),r);
        estimatedMessage = softDecoder_Intermediate_1_2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end

semilogy(gammaDB,pBitError);