clearvars;
clc;
close all;
gammaDB = 0:0.5:8;
gammaLin = 10.^(gammaDB/10);
Nsim = 2000;
k = 500;
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
        [encodedMessage,message] = encoder_Intermediate(k,1/2);
        receivedCode = channelBEC(encodedMessage,p(i));
        estimatedMessage = hardDecoder2_Intermediate_1_2(receivedCode);
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
        estimatedMessage = hardDecoder2_Intermediate_1_2(receivedCode);
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
        estimatedMessage = softDecoder2_Intermediate_1_2(receivedCode);
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
hold on;

D1 = exp(-(gammaDB*(1/2)));
D2 = sqrt(4*p.*(1-p));

y1 = D1.^5.*(12*D1.^2+4*D1+1);
y2 = D2.^5.*(12*D2.^2+4*D2+1);
semilogy(gammaDB,y1);
hold on;
semilogy(gammaDB,y2);
hold on;

y3 = 80*D1.^7+12*D1.^5;
y4 = 80*D2.^7+12*D2.^5;

semilogy(gammaDB,y3);
hold on;
semilogy(gammaDB,y4);


legend('K=3 r=1/2 BEC Simulated','K=3 r=1/2 BSC Simulated','K=3 r=1/2 AWGN Simulated','K=4 r=1/2 BEC Simulated','K=4 r=1/2 BSC Simulated','K=4 r=1/2 AWGN Simulated','K=4 r=1/3 BEC','K=4 r=1/3 BSC Simulated','K=4 r=1/3 AWGN Simulated','AWGN Theory K = 3 r = 1/2','BSC Theory K = 3 r = 1/2','AWGN Theory K = 4 r = 1/2','BSC Theory K = 4 r = 1/2');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Convolutional Coding (Basic,Intermediate,Adnavced A)');