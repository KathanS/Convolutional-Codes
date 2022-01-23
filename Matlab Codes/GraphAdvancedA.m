D1 = exp(-(gammaLin*(1/2)));
D2 = sqrt(4*p.*(1-p));

y1 = D1.^5./((1-2*D1).^2);
y2 = D2.^5./((1-2*D2).^2);
y3 = (-D1.^8+D1.^7+D1.^6)./((1-D1.*(D1.^2+2)).^2);
y4 = (-D2.^8+D2.^7+D2.^6)./((1-D2.*(D2.^2+2)).^2);

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