close all;
clearvars;
clc;
gammaDB = 0:0.5:8;
gammaLin = 10.^(gammaDB/10);
k = 500;
r = 1/2;
%p = qfunc(sqrt(2*r*gammaLin));
p = [0.1587    0.1447    0.1309    0.1173    0.1040    0.0912    0.0789    0.0673    0.0565    0.0466    0.0377    0.0298    0.0230    0.0173    0.0126    0.0089    0.0060];

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
legend('AWGN K=3','BSC K=3','AWGN K=4','BSC K=4');