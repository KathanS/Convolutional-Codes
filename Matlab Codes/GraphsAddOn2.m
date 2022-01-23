y7 = (-D1.^8+D1.^7+D1.^6)./((1-D1.*(D1.^2+2)).^2);
y8 = (-D2.^8+D2.^7+D2.^6)./((1-D2.*(D2.^2+2)).^2);




figure(1);
semilogy(gammaDB,pBitError5);
hold on;
semilogy(gammaDB,pBitError6);
semilogy(gammaDB,y7);
semilogy(gammaDB,y8);
legend('BSC Simulation','AWGN Simulation','AWGN Theory','BSC Theory');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Advanced A Theory vs Simulation (K = 4  r = 1/2)');
