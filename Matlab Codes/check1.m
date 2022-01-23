clearvars;
clc;
close all;
gammaDB = 0:0.5:8;
gammaLin = 10.^(gammaDB/10);
Nsim = 200;
k = 500;
r = 1/2;
%p = qfunc(sqrt(2*r*gammaLin));
p = [0.1587    0.1447    0.1309    0.1173    0.1040    0.0912    0.0789    0.0673    0.0565    0.0466    0.0377    0.0298    0.0230    0.0173    0.0126    0.0089    0.0060];
pBitError = zeros(3,length(gammaDB))-1;
[encodedMessage,message] = encoder(k);        
for i = 1:length(p)
    Nerror = [0 0 0];
    for j = 1:Nsim
        receivedCode = channelBEC(encodedMessage,p(i));
        estimatedMessage = BCJR_E(receivedCode);
        Nerror(1) = Nerror(1) + sum(xor(estimatedMessage,message));
        
        receivedCode = channelBSC(encodedMessage,p(i));
        estimatedMessage = BCJR_S(receivedCode);
        Nerror(2) = Nerror(2) + sum(xor(estimatedMessage,message));
        
        receivedCode = channelAWGN(encodedMessage,gammaLin(i),r);
        estimatedMessage = BCJR_A(receivedCode);
        Nerror(3) = Nerror(3) + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError(1,i) = Nerror(1)/(k*Nsim);
    pBitError(2,i) = Nerror(2)/(k*Nsim);
    pBitError(3,i) = Nerror(3)/(k*Nsim);
end

semilogy(gammaDB,pBitError(1,:));
hold on;
semilogy(gammaDB,pBitError(2,:));
hold on;
semilogy(gammaDB,pBitError(3,:));

legend('BEC','BSC','AWGN');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('BCJR');