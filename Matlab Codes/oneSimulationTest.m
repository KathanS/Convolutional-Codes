clearvars;
clc;
gammaDB = 0:0.5:8;
gammaLin = 10.^(gammaDB/10);
k = 500;
r = 1/2;
%p = qfunc(sqrt(2*r*gammaLin));
p = [0.1587    0.1447    0.1309    0.1173    0.1040    0.0912    0.0789    0.0673    0.0565    0.0466    0.0377    0.0298    0.0230    0.0173    0.0126    0.0089    0.0060];

s1=0;
s2=0;
for i = 1:20
    [a,b] = encoder(k);
    c = channelAWGN(a,10^0.5,1/2);
    d1 = softDecoder(c);
    d2 = softDecoder2(c);
    s1=s1+sum(xor(d1,b));
    s2=s2+sum(xor(d2,b));
    fprintf("%d\n",i);
end
fprintf("%d\n%d",s1/(500*20),s2/(500*20));