figure(8);
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
title('Advanced A Theory vs Simulation (K = 3  r = 1/2) Transfer Function in Open Form(Summation Form)');

figure(9);
semilogy(gammaDB,pBitError1);
hold on;
semilogy(gammaDB,pBitError2);
semilogy(gammaDB,pBitError3);
semilogy(gammaDB,y5);
semilogy(gammaDB,y6);
legend('BEC Simulation','BSC Simulation','AWGN Simulation','AWGN Theory','BSC Theory');
ylabel('BER');
xlabel('gammaDB');
grid on;
title('Advanced A Theory vs Simulation (K = 3  r = 1/2) Transfer Function in Closed Form');

figure(10);
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
title('Advanced A Theory vs Simulation (K = 4  r = 1/2) Transfer Function in Open Form(Summation Form)');

