clearvars;
clc;
close all;
gammaDB = 0:0.5:8;
gammaLin = 10.^(gammaDB/10);
Nsim = 5000;
k = 500;
r = 1/2;
%p = qfunc(sqrt(2*r*gammaLin));
p = [0.1587    0.1447    0.1309    0.1173    0.1040    0.0912    0.0789    0.0673    0.0565    0.0466    0.0377    0.0298    0.0230    0.0173    0.0126    0.0089    0.0060];
pBitError1 = zeros(1,length(gammaDB))-1; 
pBitError2 = zeros(1,length(gammaDB))-1;
pBitError3 = zeros(1,length(gammaDB))-1;
pBitError4 = zeros(1,length(gammaDB))-1;
pBitError5 = zeros(1,length(gammaDB))-1;
pBitError6 = zeros(1,length(gammaDB))-1;
pBitError7 = zeros(1,length(gammaDB))-1;
pBitError8 = zeros(1,length(gammaDB))-1;
pBitError9 = zeros(1,length(gammaDB))-1;

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
    pBitError1(i) = Nerror/(k*Nsim);
end


for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder(k);
        receivedCode = channelBSC(encodedMessage,p(i));
        estimatedMessage = hardDecoder2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError2(i) = Nerror/(k*Nsim);
end


for i = 1:length(gammaLin)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder(k);
        receivedCode = channelAWGN(encodedMessage,gammaLin(i),r);
        estimatedMessage = softDecoder2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError3(i) = Nerror/(k*Nsim);
end

for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/2);
        receivedCode = channelBEC(encodedMessage,p(i));
        estimatedMessage = hardDecoder2_Intermediate_1_2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError4(i) = Nerror/(k*Nsim);
end


for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/2);
        receivedCode = channelBSC(encodedMessage,p(i));
        estimatedMessage = hardDecoder2_Intermediate_1_2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError5(i) = Nerror/(k*Nsim);
end


for i = 1:length(gammaLin)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/2);
        receivedCode = channelAWGN(encodedMessage,gammaLin(i),r);
        estimatedMessage = softDecoder2_Intermediate_1_2(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError6(i) = Nerror/(k*Nsim);
end


for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/3);
        receivedCode = channelBEC(encodedMessage,p(i));
        estimatedMessage = hardDecoder2_Intermediate_1_3(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError7(i) = Nerror/(k*Nsim);
end


for i = 1:length(p)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/3);
        receivedCode = channelBSC(encodedMessage,p(i));
        estimatedMessage = hardDecoder2_Intermediate_1_3(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError8(i) = Nerror/(k*Nsim);
end


for i = 1:length(gammaLin)
    Nerror = 0;
    for j = 1:Nsim
        [encodedMessage,message] = encoder_Intermediate(k,1/3);
        receivedCode = channelAWGN(encodedMessage,gammaLin(i),r);
        estimatedMessage = softDecoder2_Intermediate_1_3(receivedCode);
        Nerror = Nerror + sum(xor(estimatedMessage,message));
    end
    fprintf("%d\n",i);
    pBitError9(i) = Nerror/(k*Nsim);
end


D1 = exp(-(gammaDB*(1/2)));
D2 = sqrt(4*p.*(1-p));

y1 = D1.^4.*(5+12*D1.^3+4*D1.^2+32*D1.^3+64*D1.^5);
y2 = D2.^4.*(5+12*D2.^3+4*D2.^2+32*D2.^3+64*D2.^5);
y3 = 80*D1.^7+12*D1.^5;
y4 = 80*D2.^7+12*D2.^5;

%all in one
figure(1);
semilogy(gammaDB,pBitError1);
hold on;
semilogy(gammaDB,pBitError2);
semilogy(gammaDB,pBitError3);
semilogy(gammaDB,pBitError4);
semilogy(gammaDB,pBitError5);
semilogy(gammaDB,pBitError6);
semilogy(gammaDB,pBitError7);
semilogy(gammaDB,pBitError8);
semilogy(gammaDB,pBitError9);
semilogy(gammaDB,y1);
semilogy(gammaDB,y2);
semilogy(gammaDB,y3);
semilogy(gammaDB,y4);
legend('K=3 r=1/2 BEC Simulated','K=3 r=1/2 BSC Simulated','K=3 r=1/2 AWGN Simulated','K=4 r=1/2 BEC Simulated','K=4 r=1/2 BSC Simulated','K=4 r=1/2 AWGN Simulated','K=4 r=1/3 BEC','K=4 r=1/3 BSC Simulated','K=4 r=1/3 AWGN Simulated','AWGN Theory K = 3 r = 1/2','BSC Theory K = 3 r = 1/2','AWGN Theory K = 4 r = 1/2','BSC Theory K = 4 r = 1/2');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Convolutional Coding (Basic,Intermediate,Adnavced A)');

%basic

figure(2);
semilogy(gammaDB,pBitError1);
hold on;
semilogy(gammaDB,pBitError2);
semilogy(gammaDB,pBitError3);
legend('BEC','BSC','AWGN');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Basic (K = 3  r = 1/2)');

%intermediate1
figure(3);
semilogy(gammaDB,pBitError1);
hold on;
semilogy(gammaDB,pBitError2);
semilogy(gammaDB,pBitError3);
semilogy(gammaDB,pBitError4);
semilogy(gammaDB,pBitError5);
semilogy(gammaDB,pBitError6);
legend('K=3 r=1/2 BEC','K=3 r=1/2 BSC','K=3 r=1/2 AWGN','K=4 r=1/2 BEC','K=4 r=1/2 BSC','K=4 r=1/2 AWGN');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Intermediate (K = 4  r = 1/2 vs K = 3  r = 1/2)');

%intermediate2
figure(4);
semilogy(gammaDB,pBitError1);
hold on;
semilogy(gammaDB,pBitError2);
semilogy(gammaDB,pBitError3);
semilogy(gammaDB,pBitError7);
semilogy(gammaDB,pBitError8);
semilogy(gammaDB,pBitError9);
legend('K=3 r=1/2 BEC','K=3 r=1/2 BSC','K=3 r=1/2 AWGN','K=4 r=1/3 BEC','K=4 r=1/3 BSC','K=4 r=1/3 AWGN');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Intermediate (K = 4  r = 1/3 vs K = 3  r = 1/2)');

%basic_intermediate
figure(5);
semilogy(gammaDB,pBitError1);
hold on;
semilogy(gammaDB,pBitError2);
semilogy(gammaDB,pBitError3);
semilogy(gammaDB,pBitError4);
semilogy(gammaDB,pBitError5);
semilogy(gammaDB,pBitError6);
semilogy(gammaDB,pBitError7);
semilogy(gammaDB,pBitError8);
semilogy(gammaDB,pBitError9);
legend('K=3 r=1/2 BEC','K=3 r=1/2 BSC','K=3 r=1/2 AWGN','K=4 r=1/2 BEC','K=4 r=1/2 BSC','K=4 r=1/2 AWGN','K=4 r=1/3 BEC','K=4 r=1/3 BSC','K=4 r=1/3 AWGN');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('All simulations (K = 4 r = 1/3  vs   K = 4  r = 1/2  vs  K = 3  r = 1/2)');

%advanced A 1
figure(6);
semilogy(gammaDB,pBitError1);
hold on;
semilogy(gammaDB,pBitError2);
semilogy(gammaDB,pBitError3);
semilogy(gammaDB,y1);
semilogy(gammaDB,y2);
legend('BEC Simulation','BSC Simulation','AWGN Simulation','AWGN Theory','BSC Theory');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Advanced A Theory vs Simulation (K = 3  r = 1/2)');

%advanced A 2
figure(7);
semilogy(gammaDB,pBitError4);
hold on;
semilogy(gammaDB,pBitError5);
semilogy(gammaDB,pBitError6);
semilogy(gammaDB,y3);
semilogy(gammaDB,y4);
legend('BEC Simulation','BSC Simulation','AWGN Simulation','AWGN Theory','BSC Theory');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Advanced A Theory vs Simulation (K = 4  r = 1/2)');
