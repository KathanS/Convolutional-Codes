clearvars;
clc;
close all;
gammaDB = 0:0.5:8;
gammaLin = 10.^(gammaDB/10);
Nsim = 10;
k = 5000;
r = 1/2;
%p = qfunc(sqrt(2*r*gammaLin));
p = [0.1587    0.1447    0.1309    0.1173    0.1040    0.0912    0.0789    0.0673    0.0565    0.0466    0.0377    0.0298    0.0230    0.0173    0.0126    0.0089    0.0060];
pBitError = zeros(1,length(gammaDB))-1; 

%uncoded
%semilogy(gammaDB,p);
%hold on;

for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder(k);
        receivedCode = channelBEC(encodedMessage,p(i));
        estimatedMessage = hardDecoder2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError(i) = Nerror/(k*Nsim);
end

semilogy(gammaDB,pBitError);
hold on;

for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder(k);
        receivedCode = channelBSC(encodedMessage,p(i));
        estimatedMessage = hardDecoder2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError(i) = Nerror/(k*Nsim);
end

semilogy(gammaDB,pBitError);
hold on;

for i = 1:length(gammaLin)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder(k);
        receivedCode = channelAWGN(encodedMessage,gammaLin(i),r);
        estimatedMessage = softDecoder2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError(i) = Nerror/(k*Nsim);
end
semilogy(gammaDB,pBitError);
hold on;

for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/3);
        receivedCode = channelBEC(encodedMessage,p(i));
        estimatedMessage = hardDecoder2_Intermediate_1_3(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end

semilogy(gammaDB,pBitError);
hold on;

for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/3);
        receivedCode = channelBSC(encodedMessage,p(i));
        estimatedMessage = hardDecoder2_Intermediate_1_3(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end

semilogy(gammaDB,pBitError);
hold on;

for i = 1:length(gammaLin)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/3);
        receivedCode = channelAWGN(encodedMessage,gammaLin(i),r);
        estimatedMessage = softDecoder2_Intermediate_1_3(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end

semilogy(gammaDB,pBitError);

legend('K=3 r=1/2 BEC','K=3 r=1/2 BSC','K=3 r=1/2 AWGN','K=4 r=1/3 BEC','K=4 r=1/3 BSC','K=4 r=1/3 AWGN');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Intermediate (K = 4  r = 1/3 vs K = 3  r = 1/2)');