clc;
close all;
D1 = exp(-(gammaLin*(1/2)));
D2 = sqrt(4*p.*(1-p));

y1 = D1.^5./((1-2*D1).^2);
y2 = D2.^5./((1-2*D2).^2);
y3 = (-D1.^8+D1.^7+D1.^6)./((1-D1.*(D1.^2+2)).^2);
y4 = (-D2.^8+D2.^7+D2.^6)./((1-D2.*(D2.^2+2)).^2);

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
semilogy(gammaDB,pBitError2);
hold on;
semilogy(gammaDB,pBitError3);
semilogy(gammaDB,y1);
semilogy(gammaDB,y2);
legend('BSC Simulation','AWGN Simulation','AWGN Theory','BSC Theory');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Advanced A Theory vs Simulation (K = 3  r = 1/2)');

%advanced A 2
figure(7);
semilogy(gammaDB,pBitError5);
hold on;
semilogy(gammaDB,pBitError6);
semilogy(gammaDB,y3);
semilogy(gammaDB,y4);
legend('BSC Simulation','AWGN Simulation','AWGN Theory','BSC Theory');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Advanced A Theory vs Simulation (K = 4  r = 1/2)');