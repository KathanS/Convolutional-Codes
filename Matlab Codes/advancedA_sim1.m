clearvars;
clc;
close all;
gammaDB = 0:0.5:8;
gammaLin = 10.^(gammaDB/10);
Nsim = 10000;
k = 50;
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
        fprintf('%d %d\n',i,j);
        [encodedMessage,message] = encoder(k);
        receivedCode = channelBEC(encodedMessage,p(i));
        estimatedMessage = hardDecoder(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end
pBitError
semilogy(gammaDB,pBitError);
hold on;

for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        fprintf('%d %d\n',i,j);
        [encodedMessage,message] = encoder(k);
        receivedCode = channelBSC(encodedMessage,p(i));
        estimatedMessage = hardDecoder(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end
pBitError
semilogy(gammaDB,pBitError);
hold on;

for i = 1:length(gammaLin)
    Nerror = 0;
    for j = 1:Nsim
        fprintf('%d %d\n',i,j);
        [encodedMessage,message] = encoder(k);
        receivedCode = channelAWGN(encodedMessage,gammaLin(i),r);
        estimatedMessage = softDecoder(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end
pBitError
semilogy(gammaDB,pBitError);
hold on;



for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        fprintf('%d %d\n',i,j);
        [encodedMessage,message] = encoder_Intermediate(k,1/2);
        receivedCode = channelBEC(encodedMessage,p(i));
        estimatedMessage = hardDecoder_Intermediate_1_2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end
pBitError
semilogy(gammaDB,pBitError);
hold on;

for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        fprintf('%d %d\n',i,j);
        [encodedMessage,message] = encoder_Intermediate(k,1/2);
        receivedCode = channelBSC(encodedMessage,p(i));
        estimatedMessage = hardDecoder_Intermediate_1_2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end
pBitError
semilogy(gammaDB,pBitError);
hold on;

for i = 1:length(gammaLin)
    Nerror = 0;
    for j = 1:Nsim
        fprintf('%d %d\n',i,j);
        [encodedMessage,message] = encoder_Intermediate(k,1/2);
        receivedCode = channelAWGN(encodedMessage,gammaLin(i),r);
        estimatedMessage = softDecoder_Intermediate_1_2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    pBitError(i) = Nerror/(k*Nsim);
end
pBitError
semilogy(gammaDB,pBitError);
hold on;


D1 = exp(-(gammaDB*(1/2)));

D2 = sqrt(4*p.*(1-p));

y1 = D1.^5.*(12*D1.^2+4*D1+1);
y2 = D2.^5.*(12*D2.^2+4*D2+1);

y3 = 80*D1.^7+12*D1.^5;
y4 = 80*D2.^7+12*D2.^5;

semilogy(gammaDB,y1);
hold on;
semilogy(gammaDB,y2);
hold on;
semilogy(gammaDB,y3);
hold on;
semilogy(gammaDB,y4);
legend('sim K = 3 BEC','sim K = 3 BSC','sim K = 3 AWGN','sim K = 4 BEC','sim K = 4 BSC','sim K = 4 AWGN','AWGN K=3','BSC K=3','AWGN K=4','BSC K=4');
grid on;
title('rate r = 1/2');
xlabel('gammaDB');
ylabel('BER');

